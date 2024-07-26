# Script de Organización de Archivos en PowerShell

## Descripción

Este script en PowerShell organiza archivos en un directorio fuente clasificándolos por tipo y fecha de modificación. El script también elimina carpetas vacías y genera un archivo de registro detallando las acciones realizadas.

## Requisitos

- PowerShell 5.0 o superior
- Permisos de lectura y escritura en los directorios especificados

## Cómo usarlo

1. **Descargar el Script:**
   - Clona este repositorio o descarga el script `OrganizeFiles.ps1` a tu máquina local.

2. **Preparar el Entorno:**
   - Asegúrate de tener los permisos necesarios para acceder y modificar los directorios especificados.
   - Opcional: Configura el entorno de ejecución de PowerShell si no está permitido ejecutar scripts. Puedes hacerlo ejecutando `Set-ExecutionPolicy RemoteSigned` como administrador.

3. **Ejecutar el Script:**
   - Abre una terminal de PowerShell.
   - Navega al directorio donde se encuentra el script.
   - Ejecuta el script usando el siguiente comando, proporcionando las rutas del directorio fuente y el directorio de logs si son diferentes de los predeterminados:
     ```powershell
     .\OrganizeFiles.ps1 -sourceDirectory "Ruta\al\directorio\fuente" -logDirectory "Ruta\al\directorio\de\logs"
     ```

## Funciones del Script

- **Organize-FilesByExtensionAndDate:**
  - Organiza archivos por tipo (fotos, videos, documentos, música, etc.) y fecha de modificación (año, mes, día).
  - Crea carpetas para cada tipo de archivo y fecha de modificación si no existen.
  - Mueve archivos a las carpetas correspondientes.

- **Remove-EmptyDirectories:**
  - Elimina carpetas vacías recursivamente en el directorio fuente.

- **Get-FolderPrefix:**
  - Retorna el prefijo correspondiente a cada tipo de carpeta.

- **Get-MonthName y Get-DayName:**
  - Devuelven el nombre del mes y del día en español.

- **Write-Log:**
  - Registra acciones y eventos en un archivo de log.

## Puntos de Mejora

- **Validaciones Adicionales:**
  - Validar entradas de usuario para asegurar que las rutas proporcionadas existen y son accesibles.
  - Manejar casos especiales como nombres de archivos con caracteres no permitidos en Windows.

- **Soporte para Más Tipos de Archivos:**
  - Ampliar la lista de extensiones soportadas y sus respectivas carpetas de destino.

- **Interfaz Gráfica:**
  - Crear una interfaz gráfica para facilitar la configuración y ejecución del script.

## Riesgos del Uso

- **Pérdida de Datos:**
  - Mover archivos a nuevas ubicaciones puede causar pérdida de datos si hay errores en la escritura. Asegúrate de tener respaldos antes de ejecutar el script.

- **Eliminación Accidental:**
  - La eliminación de carpetas vacías podría causar pérdida de datos si estas carpetas contenían archivos ocultos o de sistema.

- **Permisos:**
  - Asegúrate de tener los permisos necesarios para modificar los directorios especificados. Ejecutar el script sin los permisos adecuados puede causar fallos.

## Contribuir

Si deseas contribuir a este proyecto, por favor, realiza un fork del repositorio, realiza tus cambios y envía un pull request. Todas las contribuciones son bienvenidas.

## Licencia

Este proyecto está licenciado bajo la Licencia MIT.
