param (
    [string]$sourceDirectory = "I:\",
    [string]$logDirectory = "I:\logs"
)

Write-Host "Bienvenido al script de organizacion de archivos."
Write-Host "Por favor, proporciona la siguiente informacion (presiona Enter para aceptar el valor predeterminado):"

$sourceDirectoryInput = Read-Host "Ruta del directorio fuente (por defecto: '$sourceDirectory')"
if (-not [string]::IsNullOrWhiteSpace($sourceDirectoryInput)) {
    $sourceDirectory = $sourceDirectoryInput
}
if (-not (Test-Path -Path $sourceDirectory)) {
    Write-Host "El directorio fuente no existe. Saliendo del script."
    exit
}
Write-Host "Ruta del directorio fuente establecida en: $sourceDirectory"

$logDirectoryInput = Read-Host "Ruta del directorio de logs (por defecto: '$logDirectory')"
if (-not [string]::IsNullOrWhiteSpace($logDirectoryInput)) {
    $logDirectory = $logDirectoryInput
}
if (-not (Test-Path -Path $logDirectory)) {
    New-Item -ItemType Directory -Path $logDirectory -Force | Out-Null
    Write-Host "Directorio de logs creado: $logDirectory"
}
Write-Host "Ruta del directorio de logs establecida en: $logDirectory"

$logFile = Join-Path -Path $logDirectory -ChildPath "OrganizeFilesLog.txt"

# Contadores para estadisticas
[int]$totalFoldersCreated = 0
[int]$totalFilesMoved = 0
[int]$totalEmptyFoldersDeleted = 0

function Write-Log {
    param (
        [string]$message,
        [string]$level = "INFO"
    )
    $logEntry = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - [$level] - $message"
    Add-Content -Path $logFile -Value $logEntry
    Write-Host $logEntry
}

function Get-FolderPrefix {
    param (
        [string]$folderName
    )
    $folderPrefixes = @{
        "Fotos"        = "01"
        "Videos"       = "02"
        "Documentos"   = "03"
        "Musica"       = "04"
        "RAW"          = "05"
        "Otros"        = "06"
        "Ejecutables"  = "07"
        "Archivos de Sistema" = "08"
        "Bases de Datos" = "09"
        "Archivos Web" = "10"
        "Archivos de Configuracion" = "11"
        "Archivos de Programacion" = "12"
    }
    return $folderPrefixes[$folderName]
}

function Remove-EmptyDirectories {
    param (
        [string]$dir
    )
    $subdirs = Get-ChildItem -Path $dir -Directory
    foreach ($subdir in $subdirs) {
        Remove-EmptyDirectories -dir $subdir.FullName
    }
    if (-not (Get-ChildItem -Path $dir)) {
        Remove-Item -Path $dir -Force
        Write-Log "Carpeta vacia eliminada: $dir"
        $global:totalEmptyFoldersDeleted++
    }
}

function Get-MonthName {
    param (
        [int]$month
    )
    $months = @("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre")
    return $months[$month - 1]
}

function Get-DayName {
    param (
        [DateTime]$date
    )
    $days = @("Domingo", "Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado")
    return $days[$date.DayOfWeek.value__]
}

function Organize-FilesByExtensionAndDate {
    param (
        [string]$directory
    )
    if (-not (Test-Path -Path $directory)) {
        Write-Log "El directorio $directory no existe." "ERROR"
        return
    }
    $files = Get-ChildItem -Path $directory -Recurse -File | Where-Object { $_.DirectoryName -notlike "$logDirectory*" }

    foreach ($file in $files) {
        try {
            Write-Log "Procesando archivo: $($file.FullName)"
            $extension = $file.Extension.ToLower().TrimStart(".")
            $modificationDate = $file.LastWriteTime
            $year = $modificationDate.Year
            $month = Get-MonthName -month $modificationDate.Month
            $day = $modificationDate.Day.ToString("00") # Formato de dos digitos para el dia
            $folder = switch ($extension) {
                {$_ -in @("jpg", "jpeg", "png", "gif", "bmp", "tiff", "webp", "svg", "ico", "heic", "heif")} {"Fotos"}
                {$_ -in @("mp4", "avi", "mov", "mkv", "flv", "wmv", "mpg", "mpeg", "webm", "3gp", "rm", "rmvb", "ts", "ogv", "m4v")} {"Videos"}
                {$_ -in @("pdf", "doc", "docx", "xls", "xlsx", "ppt", "pptx", "txt", "rtf", "odt", "ods", "odp", "tex", "md")} {"Documentos"}
                {$_ -in @("mp3", "wav", "flac", "aac", "ogg")} {"Musica"}
                {$_ -in @("raw", "arw", "cr2", "nef", "dng", "orf", "rw2", "sr2", "srf", "raf", "3fr", "erf", "k25", "kdc", "mef", "mrw", "nrw", "ptx", "pef", "r3d", "srw", "x3f")} {"RAW"}
                {$_ -in @("exe", "bat", "msi")} {"Ejecutables"}
                {$_ -in @("sys", "dll", "ini")} {"Archivos de Sistema"}
                {$_ -in @("sql", "db", "mdb", "accdb")} {"Bases de Datos"}
                {$_ -in @("html", "htm", "css", "js", "php")} {"Archivos Web"}
                {$_ -in @("cfg", "conf", "ini", "xml", "json", "yaml", "yml")} {"Archivos de Configuracion"}
                {$_ -in @("java", "py", "cs", "cpp", "c", "h", "sh", "rb", "php", "html", "js")} {"Archivos de Programacion"}
                default {"Otros"}
            }

            $folderPrefix = Get-FolderPrefix -folderName $folder
            $typeFolder = Join-Path -Path $directory -ChildPath "$($folderPrefix)-$folder"
            $yearFolder = Join-Path -Path $typeFolder -ChildPath "$year"
            $monthFolder = Join-Path -Path $yearFolder -ChildPath "$month"
            $dayFolder = Join-Path -Path $monthFolder -ChildPath "$day"

            if (-not (Test-Path -Path $dayFolder)) {
                New-Item -ItemType Directory -Path $dayFolder -Force | Out-Null
                Write-Log "Directorio creado: $dayFolder"
                $global:totalFoldersCreated++
            }

            Move-Item -Path $file.FullName -Destination $dayFolder -Force
            Write-Log "Archivo movido a: $dayFolder"
            $global:totalFilesMoved++
        } catch {
            Write-Log "Error moviendo el archivo $($file.FullName): $_" "ERROR"
        }
    }
}

function Check-ManualFolders {
    param (
        [string]$directory
    )
    
    $expectedPrefixes = @("01-Fotos", "02-Videos", "03-Documentos", "04-Musica", "05-RAW", "06-Otros", "07-Ejecutables", "08-Archivos_de_Sistema", "09-Bases_de_Datos", "10-Archivos_Web", "11-Archivos_de_Configuracion", "12-Archivos_de_Programacion")
    
    $folders = Get-ChildItem -Path $directory -Directory -Recurse
    foreach ($folder in $folders) {
        $folderName = $folder.Name
        $folderPath = $folder.FullName
        
        if (-not ($expectedPrefixes -contains ($folderName -split '-')[0])) {
            Write-Host "Subcarpeta no gestionada detectada: $folderPath"
            Write-Log "Subcarpeta no gestionada detectada: $folderPath" "WARNING"
        }
    }
}

Write-Log "Inicio de la organizacion de archivos en: $sourceDirectory"

Check-ManualFolders -directory $sourceDirectory
Organize-FilesByExtensionAndDate -directory $sourceDirectory
Remove-EmptyDirectories -dir $sourceDirectory

Write-Host "Organizacion completada."
Write-Log "Organizacion completada."
Write-Host "Total de carpetas creadas: $totalFoldersCreated"
Write-Host "Total de archivos movidos: $totalFilesMoved"
Write-Host "Total de carpetas vacias eliminadas: $totalEmptyFoldersDeleted"
