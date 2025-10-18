# YouTube playlist to Markdown converter

Utility to convert user-specified YouTube playlist into a Markdown list with links to each video.

<https://gitlab.com/brlin/youtube-playlist-to-markdown-converter>  
[![The GitLab CI pipeline status badge of the project's `main` branch](https://gitlab.com/brlin/youtube-playlist-to-markdown-converter/badges/main/pipeline.svg?ignore_skipped=true "Click here to check out the comprehensive status of the GitLab CI pipelines")](https://gitlab.com/brlin/youtube-playlist-to-markdown-converter/-/pipelines) [![GitHub Actions workflow status badge](https://github.com/brlin-tw/youtube-playlist-to-markdown-converter/actions/workflows/check-potential-problems.yml/badge.svg "GitHub Actions workflow status")](https://github.com/brlin-tw/youtube-playlist-to-markdown-converter/actions/workflows/check-potential-problems.yml) [![pre-commit enabled badge](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white "This project uses pre-commit to check potential problems")](https://pre-commit.com/) [![REUSE Specification compliance badge](https://api.reuse.software/badge/gitlab.com/brlin/youtube-playlist-to-markdown-converter "This project complies to the REUSE specification to decrease software licensing costs")](https://api.reuse.software/info/gitlab.com/brlin/youtube-playlist-to-markdown-converter)

\#youtube \#utility \#markdown

## Prerequisites

The following are the prerequisites that you need to prepare before using this product:

* The host system must have the following software installed and their commands available in your command search PATHs:
    + Bash  
      The runtime environment of the utility.
    + yt-dlp  
      The utility uses `yt-dlp` to fetch the playlist information from YouTube.  
      Refer to the [yt-dlp GitHub repository](https://github.com/yt-dlp/yt-dlp) for more information.

## Usage

Refer to the following steps to use the utility:

1. Download the release archive from [the Releases page](https://gitlab.com/brlin/youtube-playlist-to-markdown-converter/-/releases).
1. Upload the release archive to your computer.
1. Acquire a text terminal of your computer.
1. Run the following command to extract the release archive:

    ```bash
    tar xf /path/to/youtube-playlist-to-markdown-converter-X.Y.Z.tar.gz
    ```

    Replace `/path/to/youtube-playlist-to-markdown-converter-X.Y.Z.tar.gz` with the actual path of the release archive on your computer.

1. Run the following command to convert a YouTube playlist into a Markdown list:

    ```bash
    /path/to/youtube-playlist-to-markdown-converter-X.Y.Z/convert-youtube-playlist-to-markdown.sh <playlist_url>
    ```

   Replace the `/path/to/youtube-playlist-to-markdown-converter-X.Y.Z` placeholder with the actual path of the extracted directory on your computer.

   Replace the `<playlist_url>` placeholder with the actual URL of the YouTube playlist you want to convert.

   The resulting unordered Markdown list will be printed to the standard output of your terminal.

## Licensing

Unless otherwise noted([comment headers](https://reuse.software/spec-3.3/#comment-headers)/[REUSE.toml](https://reuse.software/spec-3.3/#reusetoml)), this product is licensed under [the 3.0 version of GNU Affero General Public License](https://www.gnu.org/licenses/agpl-3.0.html), or any of its more recent versions of your preference.

This work complies to [the REUSE Specification](https://reuse.software/spec/), refer to the [REUSE - Make licensing easy for everyone](https://reuse.software/) website for info regarding the licensing of this product.
