#################### Oficial ############################## 
db._create("Oficial")
db._query(
aql`INSERT {  placa: 1,
  dni: 25346251,
  nombre: "Pablo",
  apellido: "Megueres",
  rango: "Coronel",
  fechaIngreso: DATE_ISO8601(2008, 3, 4),
  tipo: null,
  idDepartamento: 1,
  asignaciones: 
  [  {  idAsignacion: 1,
      fechaInicio: DATE_ISO8601(2008, 3, 4),
      idDesignacion: 1,
      placa: 1,
      sumarios: [],
      designacion: {  idDesignacion: 1,
        nombre: "Transito"
      }
    },
    {  idAsignacion: 2,
      fechaInicio: DATE_ISO8601(2010, 3, 4),
      idDesignacion: 4,
      placa: 1,
      sumarios: [],
      designacion: {  idDesignacion: 4,
        nombre: "Patrullaje"
      }
    }
  ]
} INTO Oficial`);

db._query(
aql`INSERT {  placa: 4,
  dni: 14276572,
  nombre: "Erica",
  apellido: "Trungetili",
  rango: "Teniente",
  fechaIngreso: DATE_ISO8601(2012, 11, 10),
  tipo: null,
  idDepartamento: 1,
  asignaciones: 
  [  {  idAsignacion: 7,
      fechaInicio: DATE_ISO8601(2012, 11, 10),
      idDesignacion: 4,
      placa: 4,
      sumarios: 
      [  {  idSumario: 1,
          fecha: DATE_ISO8601(2013, 5, 4),
          observacion: null,
          resultado: null,
          placa: 3,
          idAsignacion: 7,
          idEstadoSumario: 2,
          estadoSumario: {  idEstadoSumario: 2,
            estado: "En Proceso"
          }
        }
      ],
      designacion: {  idDesignacion: 4,
        nombre: "Patrullaje"
      }
    },
    {  idAsignacion: 8,
      fechaInicio: DATE_ISO8601(2016, 11, 10),
      idDesignacion: 5,
      placa: 4,
      sumarios: [],
      designacion: {  idDesignacion: 5,
        nombre: "SWAT"
      }
    }
  ]
} INTO Oficial`);

db._query(
aql`INSERT {  placa: 5,
  dni: 23468131,
  nombre: "Fabian",
  apellido: "Rodriguez",
  rango: "Cabp",
  fechaIngreso: DATE_ISO8601(2011, 2, 4),
  tipo: null,
  idDepartamento: 8,
  asignaciones: 
  [  {  idAsignacion: 9,
      fechaInicio: DATE_ISO8601(2011, 2, 4),
      idDesignacion: 7,
      placa: 5,
      sumarios: [],
      designacion: {  idDesignacion: 7,
        nombre: "Policia Cientifica"
      }
    },
    {  idAsignacion: 10,
      fechaInicio: DATE_ISO8601(2013, 2, 4),
      idDesignacion: 10,
      placa: 5,
      sumarios: [],
      designacion: {  idDesignacion: 10,
        nombre: "Antiterrorista"
      }
    }
  ]
} INTO Oficial`);

db._query(
aql`INSERT {  placa: 6,
  dni: 28624356,
  nombre: "Cristina",
  apellido: "Peralta",
  rango: "General",
  fechaIngreso: DATE_ISO8601(2010, 2, 4),
  tipo: null,
  idDepartamento: 5,
  asignaciones: 
  [  {  idAsignacion: 11,
      fechaInicio: DATE_ISO8601(2010, 2, 4),
      idDesignacion: 6,
      placa: 6,
      sumarios: 
      [  {  idSumario: 2,
          fecha: DATE_ISO8601(2011, 9, 22),
          observacion: "Se afano todo el pibe",
          resultado: null,
          placa: 7,
          idAsignacion: 11,
          idEstadoSumario: 1,
          estadoSumario: {  idEstadoSumario: 1,
            estado: "Iniciado"
          }
        }
      ],
      designacion: {  idDesignacion: 6,
        nombre: "Narcotrafico"
      }
    },
    {  idAsignacion: 12,
      fechaInicio: DATE_ISO8601(2018, 2, 4),
      idDesignacion: 6,
      placa: 6,
      sumarios: [],
      designacion: {  idDesignacion: 6,
        nombre: "Narcotrafico"
      }
    }
  ]
} INTO Oficial`);

db._query(
aql`INSERT {  placa: 8,
  dni: 14534652,
  nombre: "Mariana",
  apellido: "Pineri",
  rango: "Coronel",
  fechaIngreso: DATE_ISO8601(2011, 5, 4),
  tipo: null,
  idDepartamento: 9,
  asignaciones: 
  [  {  idAsignacion: 15,
      fechaInicio: DATE_ISO8601(2011, 5, 4),
      idDesignacion: 8,
      placa: 8,
      sumarios: [],
      designacion: {  idDesignacion: 8,
        nombre: "Delitos financieros"
      }
    },
    {  idAsignacion: 16,
      fechaInicio: DATE_ISO8601(2012, 5, 4),
      idDesignacion: 5,
      placa: 8,
      sumarios: [],
      designacion: {  idDesignacion: 5,
        nombre: "SWAT"
      }
    }
  ]
} INTO Oficial`);

db._query(
aql`INSERT {  placa: 9,
  dni: 28246324,
  nombre: "Nestor",
  apellido: "Williams",
  rango: "Cabo",
  fechaIngreso: DATE_ISO8601(2010, 5, 4),
  tipo: null,
  idDepartamento: 3,
  asignaciones: 
  [  {  idAsignacion: 17,
      fechaInicio: DATE_ISO8601(2010, 5, 4),
      idDesignacion: 9,
      placa: 9,
      sumarios: [],
      designacion: {  idDesignacion: 9,
        nombre: "Cybercrimen"
      }
    },
    {  idAsignacion: 18,
      fechaInicio: DATE_ISO8601(2010, 5, 4),
      idDesignacion: 3,
      placa: 9,
      sumarios: [],
      designacion: {  idDesignacion: 3,
        nombre: "Espionaje"
      }
    }
  ]
} INTO Oficial`);

db._query(
aql`INSERT {  placa: 10,
  dni: 32565470,
  nombre: "Camilo",
  apellido: "Petrassi",
  rango: "General",
  fechaIngreso: DATE_ISO8601(2010, 2, 1),
  tipo: null,
  idDepartamento: 2,
  asignaciones: 
  [  {  idAsignacion: 19,
      fechaInicio: DATE_ISO8601(2010, 2, 1),
      idDesignacion: 10,
      placa: 10,
      sumarios: [],
      designacion: {  idDesignacion: 10,
        nombre: "Antiterrorista"
      }
    },
    {  idAsignacion: 20,
      fechaInicio: DATE_ISO8601(2016, 2, 1),
      idDesignacion: 8,
      placa: 10,
      sumarios: [],
      designacion: {  idDesignacion: 8,
        nombre: "Delitos financieros"
      }
    },
    {  idAsignacion: 21,
      fechaInicio: DATE_ISO8601(2013, 2, 1),
      idDesignacion: 7,
      placa: 10,
      sumarios: [],
      designacion: {  idDesignacion: 7,
        nombre: "Policia Cientifica"
      }
    }
  ]
} INTO Oficial`);

db._query(
aql`INSERT {  placa: 3,
  dni: 15349526,
  nombre: "Daniel",
  apellido: "Perez",
  rango: "Teniente",
  fechaIngreso: DATE_ISO8601(2010, 2, 5),
  tipo: "Investigador",
  idDepartamento: 1,
  asignaciones: 
  [  {  idAsignacion: 5,
      fechaInicio: DATE_ISO8601(2010, 2, 5),
      idDesignacion: 2,
      placa: 3,
      sumarios: [],
      designacion: {  idDesignacion: 2,
        nombre: "Vigilancia Bancaria"
      }
    },
    {  idAsignacion: 6,
      fechaInicio: DATE_ISO8601(2015, 5, 5),
      idDesignacion: 8,
      placa: 3,
      sumarios: [],
      designacion: {  idDesignacion: 8,
        nombre: "Delitos financieros"
      }
    }
  ]
} INTO Oficial`);

db._query(
aql`INSERT {  placa: 7,
  dni: 35246243,
  nombre: "Roque",
  apellido: "Villalba",
  rango: "Teniente",
  fechaIngreso: DATE_ISO8601(2011, 2, 4),
  tipo: "Investigador",
  idDepartamento: 4,
  asignaciones: 
  [  {  idAsignacion: 13,
      fechaInicio: DATE_ISO8601(2011, 2, 4),
      idDesignacion: 4,
      placa: 7,
      sumarios: [],
      designacion: {  idDesignacion: 4,
        nombre: "Patrullaje"
      }
    },
    {  idAsignacion: 14,
      fechaInicio: DATE_ISO8601(2017, 2, 4),
      idDesignacion: 7,
      placa: 7,
      sumarios: [],
      designacion: {  idDesignacion: 7,
        nombre: "Policia Cientifica"
      }
    }
  ]
} INTO Oficial`);

db._query(
aql`INSERT {  placa: 2,
  dni: 15349524,
  nombre: "Jorge",
  apellido: "Perez",
  rango: "Teniente",
  fechaIngreso: DATE_ISO8601(2010, 2, 5),
  tipo: "Investigador",
  idDepartamento: 1,
  asignaciones: 
  [  {  idAsignacion: 3,
      fechaInicio: DATE_ISO8601(2010, 2, 5),
      idDesignacion: 1,
      placa: 2,
      sumarios: 
      [  {  idSumario: 3,
          fecha: DATE_ISO8601(2011, 1, 2),
          observacion: "Coimeado",
          resultado: "Terrible delincuente",
          placa: 3,
          idAsignacion: 3,
          idEstadoSumario: 3,
          estadoSumario: {  idEstadoSumario: 3,
            estado: "Concluyo"
          }
        },
        {  idSumario: 4,
          fecha: DATE_ISO8601(2012, 1, 2),
          observacion: "Narco",
          resultado: null,
          placa: 7,
          idAsignacion: 3,
          idEstadoSumario: 2,
          estadoSumario: {  idEstadoSumario: 2,
            estado: "En Proceso"
          }
        }
      ],
      designacion: {  idDesignacion: 1,
        nombre: "Transito"
      }
    },
    {  idAsignacion: 4,
      fechaInicio: DATE_ISO8601(2014, 2, 5),
      idDesignacion: 7,
      placa: 2,
      sumarios: [],
      designacion: {  idDesignacion: 7,
        nombre: "Policia Cientifica"
      }
    }
  ]
} INTO Oficial`);


#################### Asignacion ############################## 
db._create("Asignacion")
db._query(
aql`INSERT {  idAsignacion: 1,
  fechaInicio: DATE_ISO8601(2008, 3, 4),
  idDesignacion: 1,
  placa: 1,
  sumarios: [],
  designacion: {  idDesignacion: 1,
    nombre: "Transito"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idAsignacion: 2,
  fechaInicio: DATE_ISO8601(2010, 3, 4),
  idDesignacion: 4,
  placa: 1,
  sumarios: [],
  designacion: {  idDesignacion: 4,
    nombre: "Patrullaje"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idAsignacion: 3,
  fechaInicio: DATE_ISO8601(2010, 2, 5),
  idDesignacion: 1,
  placa: 2,
  sumarios: 
  [  {  idSumario: 3,
      fecha: DATE_ISO8601(2011, 1, 2),
      observacion: "Coimeado",
      resultado: "Terrible delincuente",
      placa: 3,
      idAsignacion: 3,
      idEstadoSumario: 3,
      estadoSumario: {  idEstadoSumario: 3,
        estado: "Concluyo"
      }
    },
    {  idSumario: 4,
      fecha: DATE_ISO8601(2012, 1, 2),
      observacion: "Narco",
      resultado: null,
      placa: 7,
      idAsignacion: 3,
      idEstadoSumario: 2,
      estadoSumario: {  idEstadoSumario: 2,
        estado: "En Proceso"
      }
    }
  ],
  designacion: {  idDesignacion: 1,
    nombre: "Transito"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idAsignacion: 4,
  fechaInicio: DATE_ISO8601(2014, 2, 5),
  idDesignacion: 7,
  placa: 2,
  sumarios: [],
  designacion: {  idDesignacion: 7,
    nombre: "Policia Cientifica"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idAsignacion: 5,
  fechaInicio: DATE_ISO8601(2010, 2, 5),
  idDesignacion: 2,
  placa: 3,
  sumarios: [],
  designacion: {  idDesignacion: 2,
    nombre: "Vigilancia Bancaria"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idAsignacion: 6,
  fechaInicio: DATE_ISO8601(2015, 5, 5),
  idDesignacion: 8,
  placa: 3,
  sumarios: [],
  designacion: {  idDesignacion: 8,
    nombre: "Delitos financieros"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idAsignacion: 7,
  fechaInicio: DATE_ISO8601(2012, 11, 10),
  idDesignacion: 4,
  placa: 4,
  sumarios: 
  [  {  idSumario: 1,
      fecha: DATE_ISO8601(2013, 5, 4),
      observacion: null,
      resultado: null,
      placa: 3,
      idAsignacion: 7,
      idEstadoSumario: 2,
      estadoSumario: {  idEstadoSumario: 2,
        estado: "En Proceso"
      }
    }
  ],
  designacion: {  idDesignacion: 4,
    nombre: "Patrullaje"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idAsignacion: 8,
  fechaInicio: DATE_ISO8601(2016, 11, 10),
  idDesignacion: 5,
  placa: 4,
  sumarios: [],
  designacion: {  idDesignacion: 5,
    nombre: "SWAT"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idAsignacion: 9,
  fechaInicio: DATE_ISO8601(2011, 2, 4),
  idDesignacion: 7,
  placa: 5,
  sumarios: [],
  designacion: {  idDesignacion: 7,
    nombre: "Policia Cientifica"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idAsignacion: 10,
  fechaInicio: DATE_ISO8601(2013, 2, 4),
  idDesignacion: 10,
  placa: 5,
  sumarios: [],
  designacion: {  idDesignacion: 10,
    nombre: "Antiterrorista"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idAsignacion: 11,
  fechaInicio: DATE_ISO8601(2010, 2, 4),
  idDesignacion: 6,
  placa: 6,
  sumarios: 
  [  {  idSumario: 2,
      fecha: DATE_ISO8601(2011, 9, 22),
      observacion: "Se afano todo el pibe",
      resultado: null,
      placa: 7,
      idAsignacion: 11,
      idEstadoSumario: 1,
      estadoSumario: {  idEstadoSumario: 1,
        estado: "Iniciado"
      }
    }
  ],
  designacion: {  idDesignacion: 6,
    nombre: "Narcotrafico"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idAsignacion: 12,
  fechaInicio: DATE_ISO8601(2018, 2, 4),
  idDesignacion: 6,
  placa: 6,
  sumarios: [],
  designacion: {  idDesignacion: 6,
    nombre: "Narcotrafico"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idAsignacion: 13,
  fechaInicio: DATE_ISO8601(2011, 2, 4),
  idDesignacion: 4,
  placa: 7,
  sumarios: [],
  designacion: {  idDesignacion: 4,
    nombre: "Patrullaje"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idAsignacion: 14,
  fechaInicio: DATE_ISO8601(2017, 2, 4),
  idDesignacion: 7,
  placa: 7,
  sumarios: [],
  designacion: {  idDesignacion: 7,
    nombre: "Policia Cientifica"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idAsignacion: 15,
  fechaInicio: DATE_ISO8601(2011, 5, 4),
  idDesignacion: 8,
  placa: 8,
  sumarios: [],
  designacion: {  idDesignacion: 8,
    nombre: "Delitos financieros"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idAsignacion: 16,
  fechaInicio: DATE_ISO8601(2012, 5, 4),
  idDesignacion: 5,
  placa: 8,
  sumarios: [],
  designacion: {  idDesignacion: 5,
    nombre: "SWAT"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idAsignacion: 17,
  fechaInicio: DATE_ISO8601(2010, 5, 4),
  idDesignacion: 9,
  placa: 9,
  sumarios: [],
  designacion: {  idDesignacion: 9,
    nombre: "Cybercrimen"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idAsignacion: 18,
  fechaInicio: DATE_ISO8601(2010, 5, 4),
  idDesignacion: 3,
  placa: 9,
  sumarios: [],
  designacion: {  idDesignacion: 3,
    nombre: "Espionaje"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idAsignacion: 19,
  fechaInicio: DATE_ISO8601(2010, 2, 1),
  idDesignacion: 10,
  placa: 10,
  sumarios: [],
  designacion: {  idDesignacion: 10,
    nombre: "Antiterrorista"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idAsignacion: 20,
  fechaInicio: DATE_ISO8601(2016, 2, 1),
  idDesignacion: 8,
  placa: 10,
  sumarios: [],
  designacion: {  idDesignacion: 8,
    nombre: "Delitos financieros"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idAsignacion: 21,
  fechaInicio: DATE_ISO8601(2013, 2, 1),
  idDesignacion: 7,
  placa: 10,
  sumarios: [],
  designacion: {  idDesignacion: 7,
    nombre: "Policia Cientifica"
  }
} INTO Oficial`);


#################### Designacion ############################## 
db._create("Designacion")
db._query(
aql`INSERT {  idDesignacion: 1,
  nombre: "Transito"
} INTO Oficial`);

db._query(
aql`INSERT {  idDesignacion: 2,
  nombre: "Vigilancia Bancaria"
} INTO Oficial`);

db._query(
aql`INSERT {  idDesignacion: 3,
  nombre: "Espionaje"
} INTO Oficial`);

db._query(
aql`INSERT {  idDesignacion: 4,
  nombre: "Patrullaje"
} INTO Oficial`);

db._query(
aql`INSERT {  idDesignacion: 5,
  nombre: "SWAT"
} INTO Oficial`);

db._query(
aql`INSERT {  idDesignacion: 6,
  nombre: "Narcotrafico"
} INTO Oficial`);

db._query(
aql`INSERT {  idDesignacion: 7,
  nombre: "Policia Cientifica"
} INTO Oficial`);

db._query(
aql`INSERT {  idDesignacion: 8,
  nombre: "Delitos financieros"
} INTO Oficial`);

db._query(
aql`INSERT {  idDesignacion: 9,
  nombre: "Cybercrimen"
} INTO Oficial`);

db._query(
aql`INSERT {  idDesignacion: 10,
  nombre: "Antiterrorista"
} INTO Oficial`);


#################### Sumario ############################## 
db._create("Sumario")
db._query(
aql`INSERT {  idSumario: 1,
  fecha: DATE_ISO8601(2013, 5, 4),
  observacion: null,
  resultado: null,
  placa: 3,
  idAsignacion: 7,
  idEstadoSumario: 2,
  estadoSumario: {  idEstadoSumario: 2,
    estado: "En Proceso"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idSumario: 2,
  fecha: DATE_ISO8601(2011, 9, 22),
  observacion: "Se afano todo el pibe",
  resultado: null,
  placa: 7,
  idAsignacion: 11,
  idEstadoSumario: 1,
  estadoSumario: {  idEstadoSumario: 1,
    estado: "Iniciado"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idSumario: 3,
  fecha: DATE_ISO8601(2011, 1, 2),
  observacion: "Coimeado",
  resultado: "Terrible delincuente",
  placa: 3,
  idAsignacion: 3,
  idEstadoSumario: 3,
  estadoSumario: {  idEstadoSumario: 3,
    estado: "Concluyo"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idSumario: 4,
  fecha: DATE_ISO8601(2012, 1, 2),
  observacion: "Narco",
  resultado: null,
  placa: 7,
  idAsignacion: 3,
  idEstadoSumario: 2,
  estadoSumario: {  idEstadoSumario: 2,
    estado: "En Proceso"
  }
} INTO Oficial`);


#################### Direccion ############################## 
db._create("Direccion")
db._query(
aql`INSERT {  idDireccion: 1,
  calle: "9 de Julio",
  altura: 251,
  idBarrio: 6,
  barrio: {  idBarrio: 6,
    nombre: "Recoleta"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idDireccion: 2,
  calle: "San Martin",
  altura: 1250,
  idBarrio: 2,
  barrio: {  idBarrio: 2,
    nombre: "Caballito"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idDireccion: 3,
  calle: "San Martin",
  altura: 1270,
  idBarrio: 2,
  barrio: {  idBarrio: 2,
    nombre: "Caballito"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idDireccion: 4,
  calle: "San Martin",
  altura: 1250,
  idBarrio: 4,
  barrio: {  idBarrio: 4,
    nombre: "Avellaneda"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idDireccion: 5,
  calle: "Belgrano",
  altura: 103,
  idBarrio: 4,
  barrio: {  idBarrio: 4,
    nombre: "Avellaneda"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idDireccion: 6,
  calle: "Belgrano",
  altura: 1122,
  idBarrio: 4,
  barrio: {  idBarrio: 4,
    nombre: "Avellaneda"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idDireccion: 7,
  calle: "Hipolito Yrigoyen",
  altura: 701,
  idBarrio: 5,
  barrio: {  idBarrio: 5,
    nombre: "San Isidro"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idDireccion: 8,
  calle: "Marcelo Alvear",
  altura: 802,
  idBarrio: 5,
  barrio: {  idBarrio: 5,
    nombre: "San Isidro"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idDireccion: 9,
  calle: "Marcelo Alvear",
  altura: 202,
  idBarrio: 5,
  barrio: {  idBarrio: 5,
    nombre: "San Isidro"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idDireccion: 10,
  calle: "Marcelo Alvear",
  altura: 380,
  idBarrio: 6,
  barrio: {  idBarrio: 6,
    nombre: "Recoleta"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idDireccion: 11,
  calle: "Juan Domingo Peron",
  altura: 1710,
  idBarrio: 4,
  barrio: {  idBarrio: 4,
    nombre: "Avellaneda"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idDireccion: 12,
  calle: "Juan Domingo Peron",
  altura: 1017,
  idBarrio: 4,
  barrio: {  idBarrio: 4,
    nombre: "Avellaneda"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idDireccion: 13,
  calle: "Juan Domingo Peron",
  altura: 1945,
  idBarrio: 7,
  barrio: {  idBarrio: 7,
    nombre: "sAN TELMO"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idDireccion: 14,
  calle: "JUlio Roca",
  altura: 1945,
  idBarrio: 8,
  barrio: {  idBarrio: 8,
    nombre: "Moron"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idDireccion: 15,
  calle: "Guillermo Brown",
  altura: 256,
  idBarrio: 9,
  barrio: {  idBarrio: 9,
    nombre: "Adrogue"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idDireccion: 16,
  calle: "Guillermo Brown",
  altura: 323,
  idBarrio: 9,
  barrio: {  idBarrio: 9,
    nombre: "Adrogue"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idDireccion: 17,
  calle: "Cabildo",
  altura: 5540,
  idBarrio: 1,
  barrio: {  idBarrio: 1,
    nombre: "Belgrano"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idDireccion: 18,
  calle: "Cabildo",
  altura: 5545,
  idBarrio: 1,
  barrio: {  idBarrio: 1,
    nombre: "Belgrano"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idDireccion: 19,
  calle: "Cabildo",
  altura: 6540,
  idBarrio: 1,
  barrio: {  idBarrio: 1,
    nombre: "Belgrano"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idDireccion: 20,
  calle: "Cabildo",
  altura: 7213,
  idBarrio: 1,
  barrio: {  idBarrio: 1,
    nombre: "Belgrano"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idDireccion: 21,
  calle: "Iriarte",
  altura: 2456,
  idBarrio: 3,
  barrio: {  idBarrio: 3,
    nombre: "Barracas"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idDireccion: 22,
  calle: "Iriarte",
  altura: 2356,
  idBarrio: 3,
  barrio: {  idBarrio: 3,
    nombre: "Barracas"
  }
} INTO Oficial`);

db._query(
aql`INSERT {  idDireccion: 23,
  calle: "Iriarte",
  altura: 250,
  idBarrio: 3,
  barrio: {  idBarrio: 3,
    nombre: "Barracas"
  }
} INTO Oficial`);


#################### Direccion ############################## 
db._create("Barrio")
db._query(
aql`INSERT {  idBarrio: 1,
  nombre: "Belgrano"
} INTO Oficial`);

db._query(
aql`INSERT {  idBarrio: 2,
  nombre: "Caballito"
} INTO Oficial`);

db._query(
aql`INSERT {  idBarrio: 3,
  nombre: "Barracas"
} INTO Oficial`);

db._query(
aql`INSERT {  idBarrio: 4,
  nombre: "Avellaneda"
} INTO Oficial`);

db._query(
aql`INSERT {  idBarrio: 5,
  nombre: "San Isidro"
} INTO Oficial`);

db._query(
aql`INSERT {  idBarrio: 6,
  nombre: "Recoleta"
} INTO Oficial`);

db._query(
aql`INSERT {  idBarrio: 7,
  nombre: "sAN TELMO"
} INTO Oficial`);

db._query(
aql`INSERT {  idBarrio: 8,
  nombre: "Moron"
} INTO Oficial`);

db._query(
aql`INSERT {  idBarrio: 9,
  nombre: "Adrogue"
} INTO Oficial`);


#################### Incidente ############################## 
db._create("Incidente")
db._query(
aql`INSERT {  idIncidente: 1,
  fecha: DATE_ISO8601(2018, 10, 1),
  calle_1: "Gorriti",
  calle_2: "Portugal",
  idTipoInicidente: 2,
  idDireccion: 7,
  direccion: {  idDireccion: 7,
    calle: "Hipolito Yrigoyen",
    altura: 701,
    idBarrio: 5,
    barrio: {  idBarrio: 5,
      nombre: "San Isidro"
    }
  },
  tipoIncidente: {  idTipoInicidente: 2,
    nombre: "Robo"
  },
  seguimientos: 
  [  {  numero: 1,
      fecha: DATE_ISO8601(2018, 10, 8),
      descripcion: null,
      conclusion: null,
      idIncidente: 1,
      placa: 2,
      idEstadoSeguimiento: 2,
      estadoSegumiento: {  idEstadoSeguimiento: 2,
        estado: "En Proceso"
      }
    },
    {  numero: 2,
      fecha: DATE_ISO8601(2018, 10, 9),
      descripcion: null,
      conclusion: null,
      idIncidente: 1,
      placa: 9,
      idEstadoSeguimiento: 2,
      estadoSegumiento: {  idEstadoSeguimiento: 2,
        estado: "En Proceso"
      }
    },
    {  numero: 3,
      fecha: DATE_ISO8601(2018, 10, 11),
      descripcion: null,
      conclusion: null,
      idIncidente: 1,
      placa: null,
      idEstadoSeguimiento: 1,
      estadoSegumiento: {  idEstadoSeguimiento: 1,
        estado: "Pendiente"
      }
    }
  ]
} INTO Oficial`);

db._query(
aql`INSERT {  idIncidente: 2,
  fecha: DATE_ISO8601(2018, 10, 4),
  calle_1: "Pavon",
  calle_2: "Mitre",
  idTipoInicidente: 4,
  idDireccion: 17,
  direccion: {  idDireccion: 17,
    calle: "Cabildo",
    altura: 5540,
    idBarrio: 1,
    barrio: {  idBarrio: 1,
      nombre: "Belgrano"
    }
  },
  tipoIncidente: {  idTipoInicidente: 4,
    nombre: "Homicidio"
  },
  seguimientos: 
  [  {  numero: 4,
      fecha: DATE_ISO8601(2018, 10, 12),
      descripcion: "Buscando al asesino",
      conclusion: "No se encontro nada",
      idIncidente: 2,
      placa: null,
      idEstadoSeguimiento: 3,
      estadoSegumiento: {  idEstadoSeguimiento: 3,
        estado: "Cerrado"
      }
    }
  ]
} INTO Oficial`);

db._query(
aql`INSERT {  idIncidente: 3,
  fecha: DATE_ISO8601(2018, 10, 9),
  calle_1: "Alcorta",
  calle_2: "Colon",
  idTipoInicidente: 3,
  idDireccion: 8,
  direccion: {  idDireccion: 8,
    calle: "Marcelo Alvear",
    altura: 802,
    idBarrio: 5,
    barrio: {  idBarrio: 5,
      nombre: "San Isidro"
    }
  },
  tipoIncidente: {  idTipoInicidente: 3,
    nombre: "Hurto"
  },
  seguimientos: []
} INTO Oficial`);


