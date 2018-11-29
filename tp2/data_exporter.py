from arango import ArangoClient
from string import Template
from abc import abstractmethod
import datetime
from psycopg2.extras import DictCursor
import psycopg2
from collections import namedtuple
import textwrap

SCHEMA = 'tp1'

class TPBD(object):
    def __enter__(self):
        try:
            self.conn = psycopg2.connect(
                dbname='tp1_bd',
                user='postgres',
                host='localhost',
                password='postgres',
                options='-c search_path={}'.format(SCHEMA)
            )
        except:
            raise Exception("Can not start connection with database!")

        return self.conn

    def __exit__(self, exc_type, exc_value, tb):
        self.conn.close()

class TypeDecoder(object):
    def decode(self, t):
        if isinstance(t, datetime.date):
            return "{:04d}-{:02d}-{:02d}".format(t.year, t.month, t.day)
        if isinstance(t, dict):
            return {k: self.decode(v) for k, v in t.items()}
        elif isinstance(t, list) or isinstance(t, tuple):
            return [self.decode(v) for v in t]
        return t

class AQLCollection(object):
    def __init__(self):
        self.decoder = TypeDecoder()
        self.objects = []

    def export(self, db, collection_name):
        collection = db.create_collection(collection_name)
        for obj in self.objects:
            collection.insert(self.decoder.decode(obj))
        return

    def append(self, obj):
        self.objects.append(obj)

class QueryMapper(object):
    container_class = list

    def __init__(self, conn, tablename, keys=None, fields=None):
        self.conn = conn
        self.mappers = {}
        self.tablename = tablename
        self.keys = keys
        self.fields = fields

    def add_mapper(self, name, mapper):
        self.mappers[name] = mapper

    def add_nested_12m_mapper(self, name, table_name, keys, left_join_key=None, fields=None):
        self.add_mapper(name, NestedOneToManyMapper(self.conn, table_name, keys, left_join_key=left_join_key or self.keys, right_join_key=self.keys, fields=fields))

    def add_nested_12m_refs_mapper(self, name, table_name, keys, left_join_key=None):
        self.add_mapper(name, NestedRefsOneToManyMapper(self.conn, table_name, keys, left_join_key=left_join_key or self.keys, right_join_key=self.keys))

    def add_nested_m21_mapper(self, name, table_name, keys, join_key=None):
        self.add_mapper(name, NestedManyToOneMapper(self.conn, table_name, keys, join_key=join_key or keys))

    def add_nested_m2m_mapper(self, name, table_name, keys, inner_tablename, left_key, fields=None):
        self.add_mapper(name, NestedManyToManyMapper(self.conn, table_name, keys, inner_tablename, keys, left_key, fields=fields))

    def add_nested_m2m_refs_mapper(self, name, table_name, keys, inner_tablename, left_key):
        self.add_mapper(name, NestedRefsManyToManyMapper(self.conn, table_name, keys, inner_tablename, keys, left_key))

    def __getitem__(self, mapper_name):
        return self.mappers[mapper_name]

    @abstractmethod
    def query(self):
        pass

    def map(self, t=None):
        self.val = t
        r = self.container_class()
        with self.conn.cursor() as cursor:
            cursor.execute(self.query())
            column_names = [desc[0] for desc in cursor.description]

            if self.fields is None:
                fields = column_names
            else:
                fields = self.fields

            for row in cursor:
                d = {k: v for k, v in zip(column_names, row) if k in fields}

                for name, mapper in self.mappers.items():
                    d[name] = mapper.map(d)

                r.append(d)
        del self.val
        return r

class TableMapper(QueryMapper):
    container_class = AQLCollection

    def query(self):
        sql = 'SELECT * FROM "{}"'.format(self.tablename)
        return sql

class NestedMapper(QueryMapper):
    pass

class NestedOneToManyMapper(NestedMapper):
    def __init__(self, conn, tablename, keys, left_join_key, right_join_key=None, fields=None):
        super(NestedOneToManyMapper, self).__init__(conn, tablename, keys, fields)
        self.left_join_key = left_join_key
        self.right_join_key = right_join_key or left_join_key

    def query(self):
        if self.fields is None:
            fields = "*"
        else:
            fields = ", ".join(map(lambda x: '"{}"'.format(x), self.fields))

        sql = 'SELECT {} FROM "{}" WHERE "{}" = {}'.format(fields,
                                                               self.tablename,
                                                               self.left_join_key,
                                                               self.val[self.right_join_key])
        return sql


class RefsMixin(object):
    def map(self, t=None):
        xs = super(RefsMixin, self).map(t)
        return [x[self.keys] for x in xs]

class NestedRefsOneToManyMapper(RefsMixin, NestedOneToManyMapper):
    def __init__(self, conn, tablename, keys, left_join_key, right_join_key=None):
        super(NestedRefsOneToManyMapper, self).__init__(conn=conn,
                                                    tablename=tablename,
                                                    keys=keys,
                                                    left_join_key=left_join_key,
                                                    right_join_key=right_join_key,
                                                    fields=[keys])

class NestedManyToOneMapper(NestedMapper):
    def __init__(self, conn, tablename, keys, join_key):
        super(NestedManyToOneMapper, self).__init__(conn, tablename, keys)
        self.join_key = join_key

    def query(self):
        sql = 'SELECT * FROM "{}" WHERE "{}" = {}'.format(self.tablename, self.keys, self.val[self.join_key])
        return sql

    def map(self, t=None):
        x = super(NestedManyToOneMapper, self).map(t)
        del t[self.join_key]
        if len(x) == 0:
            return None
        else:
            return x[0]

class NestedManyToManyMapper(NestedMapper):
    def __init__(self, conn, tablename, key, inner_tablename, join_key, left_key, fields=None):
        super(NestedManyToManyMapper, self).__init__(conn, tablename, key, fields)
        self.inner_tablename = inner_tablename
        self.left_key = left_key
        self.join_key = join_key

    def query(self):
        if self.fields is None:
            fields = "t.*"
        else:
            fields = ", ".join(map(lambda x: 't."{}"'.format(x), self.fields))

        sql = """SELECT {fields} FROM "{inner_table}" i
                 INNER JOIN "{table}" t ON i."{key}" = t."{join_key}"
                 WHERE i."{left_key}" = {x}""".format(fields=fields,
                                                      inner_table=self.inner_tablename,
                                                      table=self.tablename,
                                                      join_key=self.join_key,
                                                      key=self.keys,
                                                      left_key=self.left_key,
                                                      x=self.val[self.left_key])
        return sql

class NestedRefsManyToManyMapper(RefsMixin, NestedManyToManyMapper):
    def __init__(self, conn, tablename, key, inner_tablename, join_key, left_key):
        super(NestedRefsManyToManyMapper, self).__init__(conn, tablename, key, inner_tablename, join_key, left_key, fields=[key])


bd_name = 'tp2_bd'
with TPBD() as conn:
    client = ArangoClient(protocol='http', host='localhost', port=8529)
    sys_db = client.db('_system', username='root', password='passwd')

    if sys_db.has_database(bd_name):
        sys_db.delete_database(bd_name)

    sys_db.create_database(bd_name)
    db = client.db(bd_name)

    print("## Oficial")
    exporter = TableMapper(conn,
                           tablename="Oficial",
                           keys='placa')
    exporter.add_nested_12m_mapper('asignaciones', "Asignacion", "idAsignacion")
    exporter['asignaciones'].add_nested_12m_mapper('sumarios', "Sumario", "idSumario")
    exporter['asignaciones'].add_nested_m21_mapper('designacion', "Designacion", "idDesignacion")
    exporter['asignaciones']['sumarios'].add_nested_m21_mapper('estadoSumario', 'EstadoSumario', 'idEstadoSumario')
    exporter.map().export(db, 'Oficial')

    print("## Departamento")
    exporter = TableMapper(conn,
                           tablename="Departamento",
                           keys='idDepartamento')
    exporter.add_nested_12m_refs_mapper('oficiales_placas', "Oficial", "placa")
    exporter.map().export(db, 'Departamento')

    print("## Asignacion")
    exporter = TableMapper(conn,
                           tablename="Asignacion",
                           keys='idAsignacion')
    exporter.add_nested_12m_mapper('sumarios', "Sumario", "idSumario")
    exporter.add_nested_m21_mapper('designacion', "Designacion", "idDesignacion")
    exporter['sumarios'].add_nested_m21_mapper('estadoSumario', 'EstadoSumario', 'idEstadoSumario')
    exporter.map().export(db, 'Asignacion')

    print("## Designacion")
    exporter = TableMapper(conn,
                           tablename="Designacion",
                           keys='idDesignacion')
    exporter.add_nested_12m_refs_mapper('asignaciones_ids', "Asignacion", "idAsignacion")
    exporter.map().export(db, 'Designacion')

    print("## Sumario")
    exporter = TableMapper(conn,
                           tablename="Sumario",
                           keys='idSumario')
    exporter.add_nested_m21_mapper('estadoSumario', 'EstadoSumario', 'idEstadoSumario')
    exporter.map().export(db, 'Sumario')

    print("## Direccion")
    exporter = TableMapper(conn,
                           tablename="Direccion",
                           keys='idDireccion')
    exporter.add_nested_m21_mapper('barrio', "Barrio", "idBarrio")
    exporter.add_nested_12m_refs_mapper('incidentes_ids', "Incidente", "idIncidente")
    exporter.add_nested_m2m_refs_mapper('civiles_ids', "Civil", "dni", "ViveEn", "idDireccion")
    exporter.map().export(db, 'Direccion')

    print("## Barrio")
    exporter = TableMapper(conn, tablename="Barrio", keys='idBarrio')
    exporter.map().export(db, 'Barrio')

    print("## Incidente")
    exporter = TableMapper(conn,
                           tablename="Incidente",
                           keys='idIncidente')
    exporter.add_nested_m21_mapper('direccion', "Direccion", "idDireccion")
    exporter.add_nested_m21_mapper('tipoIncidente', "TipoIncidente", "idTipoInicidente")
    exporter.add_nested_12m_mapper('seguimientos', "Seguimiento", "idIncidente")
    exporter.add_nested_m2m_mapper('superheroes', "Superheroe", "idSuperHeroe", "SuperParticipo", "idIncidente", fields=['idSuperHeroe', 'nombre'])
    exporter['direccion'].add_nested_m21_mapper('barrio', "Barrio", "idBarrio")
    exporter['seguimientos'].add_nested_m21_mapper('estadoSegumiento', "EstadoSeguimiento", "idEstadoSeguimiento")
    exporter.map().export(db, 'Incidente')

    print("## Superheroe")
    exporter = TableMapper(conn,
                           tablename="Superheroe",
                           keys='idSuperHeroe')
    exporter.add_nested_m2m_mapper('habilidades', "Habilidad", "idHabilidad", "Posee", "idSuperHeroe")
    exporter.add_nested_m2m_refs_mapper('archienemigos_ids', "Civil", "dni", "archienemigoDe", "idSuperHeroe")
    exporter.add_nested_m2m_refs_mapper('contactos_ids', "Civil", "dni", "EsContactadoPor", "idSuperHeroe")
    exporter.add_nested_m2m_refs_mapper('incidentes_ids', "Incidente", "idIncidente", "SuperParticipo", "idSuperHeroe")
    exporter.map().export(db, 'Superheroe')

    print("## Civil")
    exporter = TableMapper(conn,
                           tablename="Civil",
                           keys='idCivil')
    exporter.add_nested_m2m_refs_mapper('archienemigos_ids', "Superheroe", "idSuperHeroe", "archienemigoDe", "dni")
    exporter.add_nested_m2m_refs_mapper('contactos_ids', "Superheroe", "idSuperHeroe", "EsContactadoPor", "dni")
    exporter.add_nested_m2m_refs_mapper('mafias_ids', "OrganizacionDelictiva", "idMafia", "EstaCompuestaPor", "dni")
    exporter.add_nested_m2m_refs_mapper('direcciones_ids', "Direccion", "idDireccion", "ViveEn", "dni")
    exporter.map().export(db, 'Civil')

    print("## OrganizacionDelictiva")
    exporter = TableMapper(conn,
                           tablename="OrganizacionDelictiva",
                           keys='idMafia')
    exporter.add_nested_m2m_mapper('civiles', "Civil", "dni", "EstaCompuestaPor", "idMafia")
    exporter.map().export(db, 'OrganizacionDelictiva')

    print("## TipoIncidente")
    exporter = TableMapper(conn,
                           tablename="TipoIncidente",
                           keys='idTipoInicidente')
    exporter.add_nested_12m_refs_mapper('incidentes_ids', "Incidente", "idIncidente")
    exporter.map().export(db, 'TipoIncidente')

    print("## RolOficial")
    exporter = TableMapper(conn,
                           tablename="RolOficial",
                           keys='idRolOficial')
    exporter.map().export(db, 'RolOficial')

    print("## RolCivil")
    exporter = TableMapper(conn,
                           tablename="RolCivil",
                           keys='idRolCivil')
    exporter.map().export(db, 'RolCivil')

    print("## TipoRelacion")
    exporter = TableMapper(conn,
                           tablename="TipoRelacion",
                           keys='idTipoRelacion')
    exporter.map().export(db, 'TipoRelacion')

    print("## Habilidad")
    exporter = TableMapper(conn,
                           tablename="Habilidad",
                           keys='idHabilidad')
    exporter.add_nested_m2m_refs_mapper('superheroes_ids', "Superheroe", "idSuperHeroe", "Posee", "idHabilidad")
    exporter.map().export(db, 'Habilidad')

    print("## EstadoSumario")
    exporter = TableMapper(conn,
                           tablename="EstadoSumario",
                           keys='idEstadoSumario')
    exporter.add_nested_12m_refs_mapper('sumarios_ids', "Sumario", "idSumario")
    exporter.map().export(db, 'EstadoSumario')

    print("## OficialSeInvolucró")
    exporter = TableMapper(conn,
                           tablename="OficialSeInvolucro")
    exporter.map().export(db, 'OficialSeInvolucro')
