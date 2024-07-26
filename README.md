# File-Organizer-USB
Este script organiza archivos en dispositivos de almacenamiento externo (discos duros, USBs, etc.) en directorios basados en su tipo de archivo y la fecha de modificación.

Uso
Requisitos Previos

    PowerShell 5.0 o superior debe estar instalado en tu sistema.
    Permisos adecuados para crear, mover y eliminar archivos y directorios en el dispositivo de almacenamiento externo.
Funciones del Script

    Organize-FilesByExtensionAndDate: Organiza archivos por extensión y fecha.
    Remove-EmptyDirectories: Elimina directorios vacíos.
    Write-Log: Registra eventos y errores en un archivo de log.
    Get-FolderPrefix: Obtiene el prefijo del directorio basado en el tipo de archivo.
    Get-MonthName: Obtiene el nombre del mes.
    Get-DayName: Obtiene el nombre del día.

Estructura de Directorios

Los archivos se organizarán en la siguiente estructura:
DispositivoExterno/
├── 01-Fotos/
│   ├── 2024/
│   │   ├── Enero/
│   │   │   └── 01-Lunes/
│   │   │       └── archivo.jpg
│   │   └── Febrero/
│   │       └── 02-Martes/
│   │           └── archivo.png
│   └── ...
├── 02-Videos/
│   └── ...
├── 03-Documentos/
│   └── ...
└── logs/
    └── OrganizeFilesLog.txt

Mejoras Sugeridas

    Añadir soporte para más tipos de archivos.
    Implementar pruebas unitarias.
    Optimizar el manejo de errores.
    Añadir una opción para definir exclusiones de carpetas específicas.

  Riesgos

    Pérdida de Datos: Asegúrate de respaldar tus archivos antes de ejecutar el script, ya que mover archivos puede causar     pérdida de datos si algo sale mal.
    Alteración No Deseada: El script está diseñado solo para dispositivos externos para evitar alterar archivos en el         disco interno. Asegúrate de especificar correctamente la ruta del dispositivo externo.

Requisitos

    PowerShell 5.0 o superior.
    Permisos adecuados para crear, mover y eliminar archivos y directorios en el dispositivo de almacenamiento externo.
    
