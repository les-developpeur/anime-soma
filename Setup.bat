@echo off
title Mise en place ..
setlocal enabledelayedexpansion
set "newname=Mise_a_jour.bat"

:: Fonction pour vérifier l'installation de Python
call :check_python

:: Vérifier si pip est installé
call :check_pip

:: Vérifier si yt-dlp et autres modules sont installés
call :check_python_packages

:: Télécharger le fichier .py depuis l'URL GitHub
call :download_file

echo [INFO] Adaptation du fichier batch...
ren "%~f0" "%newname%"

:: Terminer le script
pause
exit /b

:: ----------------------------------------
:: Fonction pour vérifier l'installation de Python
:check_python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERREUR] Python n'est pas installe.
    echo [INFO] Telechargez et installez Python depuis https://www.python.org/downloads/
    pause
    exit /b
)
goto :eof

:: Fonction pour vérifier si pip est installé
:check_pip
python -m pip --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERREUR] Pip n'est pas installe.
    echo [INFO] Installation de pip...
    python -m ensurepip
    python -m pip install --upgrade pip
)
goto :eof

:: Fonction pour vérifier si les packages Python sont installés
:check_python_packages
set PACKAGES=yt-dlp requests beautifulsoup4 numpy tkinter

for %%p in (%PACKAGES%) do (
    python -c "import %%p" >nul 2>&1
    if %errorlevel% neq 0 (
        echo [INFO] Installation de %%p...
        pip install yt-dlp
        pip install requests 
        pip install beautifulsoup4 
        pip install numpy
        pip install tkinter
    ) else (
        echo [INFO] Le package %%p est deja installe.
    )
)
goto :eof

:: Fonction pour telecharger le fichier
:download_file
pip install -U yt-dlp
cls
echo [INFO] Téléchargement du fichier .py depuis l'URL GitHub...
set URL=https://raw.githubusercontent.com/les-developpeur/anime-soma/refs/heads/main/Anime-dowload.py
set FILE_NAME=anime-dowload.py
curl -o %FILE_NAME% %URL%
curl -o gui_windows-30%-moin-rapide-mais-plus-beau.pyw https://raw.githubusercontent.com/les-developpeur/anime-soma/refs/heads/main/gui_windows.pyw
:: Vérifier si le fichier a bien été téléchargé
if exist %FILE_NAME% (
    echo [OK] Le fichier %FILE_NAME% a été téléchargé avec succès.
    msg %username% %FILE_NAME% a ete mis en place avec succes.
) else (
    echo [ERREUR] Le telechargement a echoue.
    pause
    exit /b
)
goto :eof
