#!/bin/bash

# Paramètres par défaut
lang="${2:-fr}"
extract="${3:-api}"
api_key="abc123def456"

# Vérification du paramètre obligatoire
if [ -z "$1" ]; then
    echo "Usage: $0 URL [langue] [api|w]"
    echo "  - URL: l'URL de la vidéo à télécharger"
    echo "  - langue: code de langue (défaut: fr)"
    echo "  - mode: api pour LemonFox ou w pour Whisper (défaut: api)"
    exit 1
fi

# Téléchargement audio avec capture directe du nom de fichier
echo "Téléchargement audio en cours..."
outfile=$(yt-dlp --restrict-filenames -o "%(channel)s-%(title)s.%(ext)s" -x --audio-format mp3 "$1" | 
          grep -Po '(?<=ExtractAudio] Destination: ).*(?=\.mp3)')".mp3"

# Vérification que le téléchargement a fonctionné
if [ ! -f "$outfile" ]; then
    echo "Erreur: Le téléchargement a échoué ou le fichier n'a pas été trouvé."
    exit 1
fi

# Création du répertoire de sortie basé sur le canal
download_dir="${outfile%%-*}"
output="${outfile%.mp3}.txt"
output_path="${download_dir}/$(basename "$output")"

# Création du répertoire s'il n'existe pas
if [ ! -d "${download_dir}" ]; then
  mkdir "${download_dir}"
fi

echo "Fichier téléchargé: $outfile"
echo "Dossier de sortie: $download_dir"
echo "Fichier de transcription: $output_path"

# Transcription du fichier audio
echo "Transcription en cours via ${extract}..."

if [ "$extract" = "w" ]; then
    # Utiliser Whisper localement
    whisper "$outfile" > "$output_path" || {
        echo "Erreur lors de la transcription avec Whisper"
        exit 1
    }
else
    # Utiliser l'API LemonFox
    curl -s https://api.lemonfox.ai/v1/audio/transcriptions \
        -H "Authorization: $api_key" \
        -F "file=@$outfile" \
        -F "language=$lang" \
        -F "response_format=json" > "$output_path" || {
        echo "Erreur lors de la transcription avec l'API LemonFox"
        exit 1
    }
fi

# Vérification de la transcription
if [ ! -s "$output_path" ]; then
    echo "Attention: Le fichier de transcription semble vide."
else
    echo "Transcription terminée avec succès."
fi

# Nettoyage
rm -v "$outfile"

echo "Traitement terminé. Transcription enregistrée dans: $output_path"
