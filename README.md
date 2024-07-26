# Script de Organización de Archivos en PowerShell

## Descripción

Este script en PowerShell está diseñado para organizar archivos en un directorio fuente clasificándolos por tipo y fecha de modificación. Los archivos se mueven a subcarpetas creadas automáticamente en función de su extensión y la fecha de última modificación. El script también elimina carpetas vacías y genera un archivo de registro detallado que documenta todas las acciones realizadas.

## Requisitos

- **PowerShell 5.0 o superior:** El script requiere una versión reciente de PowerShell para funcionar correctamente.
- **Permisos de lectura y escritura:** Debes tener permisos adecuados en los directorios que deseas organizar y en el directorio donde se guardarán los logs.

## Cómo usarlo

1. **Descargar el Script:**
   - Clona este repositorio o descarga el archivo `OrganizeFiles.ps1` a tu máquina local.
   - Comando para clonar el repositorio:
     ```bash
     git clone https://github.com/tu-usuario/tu-repositorio.git
     ```

2. **Preparar el Entorno:**
   - **Permisos de Ejecución:** Si es necesario, configura el entorno de ejecución de PowerShell para permitir la ejecución de scripts. Ejecuta el siguiente comando en PowerShell con privilegios de administrador:
     ```powershell
     Set-ExecutionPolicy RemoteSigned
     ```
   - **Permisos de Directorio:** Asegúrate de tener permisos necesarios para acceder y modificar los directorios especificados en el script.

3. **Ejecutar el Script:**
   - Abre una terminal de PowerShell como administrador.
   - Navega al directorio donde se encuentra el script:
     ```powershell
     cd C:\ruta\al\directorio\del\script
     ```
   - Ejecuta el script usando el siguiente comando, proporcionando las rutas del directorio fuente y del directorio de logs si son diferentes de los predeterminados:
     ```powershell
     .\OrganizeFiles.ps1 -sourceDirectory "C:\Ruta\al\directorio\fuente" -logDirectory "C:\Ruta\al\directorio\de\logs"
     ```

## Funciones del Script

### `Organize-FilesByExtensionAndDate`

- **Descripción:** Organiza archivos por tipo (fotos, videos, documentos, música, etc.) y fecha de modificación (año, mes, día). Crea carpetas para cada tipo de archivo y fecha si no existen y mueve los archivos a las carpetas correspondientes.
- **Parámetros:**
  - `$directory`: Ruta del directorio donde se encuentran los archivos a organizar.

### `Remove-EmptyDirectories`

- **Descripción:** Elimina carpetas vacías de manera recursiva en el directorio especificado.
- **Parámetros:**
  - `$dir`: Ruta del directorio en el que se eliminarán las carpetas vacías.

### `Get-FolderPrefix`

- **Descripción:** Retorna un prefijo numérico correspondiente a cada tipo de carpeta (por ejemplo, "01" para "Fotos").
- **Parámetros:**
  - `$folderName`: Nombre del tipo de carpeta (e.g., "Fotos", "Videos").

### `Get-MonthName`

- **Descripción:** Devuelve el nombre del mes en español basado en un número de mes.
- **Parámetros:**
  - `$month`: Número del mes (1-12).

### `Get-DayName`

- **Descripción:** Devuelve el nombre del día de la semana en español basado en una fecha.
- **Parámetros:**
  - `$date`: Objeto `DateTime` con la fecha deseada.

### `Write-Log`

- **Descripción:** Registra acciones y eventos en un archivo de log, incluyendo errores y mensajes informativos.
- **Parámetros:**
  - `$message`: Mensaje a registrar.
  - `$level`: Nivel del log ("INFO", "ERROR").

## Puntos de Mejora

- **Validaciones Adicionales:**
  - Implementar validaciones para asegurar que las rutas proporcionadas existen y son accesibles.
  - Manejar nombres de archivos con caracteres no permitidos en Windows.

- **Soporte para Más Tipos de Archivos:**
  - Ampliar la lista de extensiones soportadas y definir nuevas categorías de carpetas.

- **Interfaz Gráfica:**
  - Desarrollar una interfaz gráfica para facilitar la configuración y ejecución del script, haciendo el uso más accesible para usuarios no técnicos.

- **Optimización del Rendimiento:**
  - Mejorar el rendimiento del script para manejar grandes volúmenes de archivos y directorios.

## Riesgos del Uso

- **Pérdida de Datos:**
  - Mover archivos a nuevas ubicaciones puede provocar pérdida de datos en caso de errores durante el proceso. Asegúrate de tener respaldos antes de ejecutar el script.

- **Eliminación Accidental:**
  - La eliminación de carpetas vacías podría afectar datos si estas carpetas contenían archivos ocultos o de sistema.

- **Permisos:**
  - Ejecutar el script sin los permisos adecuados puede causar fallos en la ejecución. Verifica los permisos necesarios en los directorios y para la ejecución del script.

## Contribuir

¡Las contribuciones son bienvenidas! Si deseas contribuir a este proyecto, por favor sigue estos pasos:

1. Realiza un fork del repositorio.
2. Crea una nueva rama (`git checkout -b feature/nueva-funcionalidad`).
3. Realiza tus cambios y haz un commit (`git commit -am 'Añadir nueva funcionalidad'`).
4. Haz un push a tu rama (`git push origin feature/nueva-funcionalidad`).
5. Abre un Pull Request.

## Licencia

Este proyecto está licenciado bajo la Licencia MIT. Consulta el archivo [LICENSE](LICENSE) para más detalles.

---

¡Gracias por usar nuestro organizador de archivos! Esperamos que te sea de utilidad.
