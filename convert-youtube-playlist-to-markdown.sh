#!/usr/bin/env bash
# Utility to convert user-specified YouTube playlist into a Markdown list with
# links to each video.
#
# Copyright 2024 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: AGPL-3.0-or-later

main(){
    if test "${#script_args[*]}" -ne 1; then
        printf 'Usage: %s PLAYLIST_URL\n' "${script_basecommand}" 1>&2
        exit 1
    fi

    local playlist_url="${1}"; shift

    local youtube_playlist_regex='^https?:\/\/(www\.)?youtube\.com\/playlist\?list=.*$'
    if ! [[ "${playlist_url}" =~ ${youtube_playlist_regex} ]]; then
        printf 'Error: Invalid YouTube playlist URL provided.\n' 1>&2
        exit 1
    fi

    if test -z "${playlist_url}"; then
        printf 'Error: A playlist URL must be provided.\n' 1>&2
        exit 1
    fi

    # References:
    #
    # * https://github.com/yt-dlp/yt-dlp#json-output
    # * https://github.com/yt-dlp/yt-dlp#flat-playlists
    local video_info
    if ! video_info="$(
        yt-dlp \
            --flat-playlist \
            --dump-json \
            "${playlist_url}"
        )"; then
        printf 'Error: Failed to retrieve video information using yt-dlp.\n' 1>&2
        exit 1
    fi

    local video_list_raw
    if ! video_list_raw="$( \
        jq \
            -r \
            '.title, .webpage_url' \
            <<< "${video_info}"
        )"; then
        printf 'Error: Failed to extract video list from JSON.\n' 1>&2
        exit 1
    fi

    local title
    local url
    while read -r title && read -r url; do
        printf -- '* [%s](%s)\n' "${title}" "${url}"
    done <<< "${video_list_raw}"

    exit 0
}

set_opts=(
    # Terminate script execution when an unhandled error occurs
    -o errexit
    -o errtrace

    # Terminate script execution when an unset parameter variable is
    # referenced
    -o nounset
)
if ! set "${set_opts[@]}"; then
    printf \
        'Error: Unable to configure the defensive interpreter behaviors.\n' \
        1>&2
    exit 1
fi

required_commands=(
    yt-dlp
    jq
    realpath
)
flag_required_command_check_failed=false
for command in "${required_commands[@]}"; do
    if ! command -v "${command}" >/dev/null; then
        flag_required_command_check_failed=true
        printf \
            'Error: This program requires the "%s" command to be available in your command search PATHs.\n' \
            "${command}" \
            1>&2
    fi
done
if test "${flag_required_command_check_failed}" == true; then
    printf \
        'Error: Required command check failed, please check your installation.\n' \
        1>&2
    exit 1
fi

if test -v BASH_SOURCE; then
    # Convenience variables may not need to be referenced
    # shellcheck disable=SC2034
    {
        if ! script="$(
            realpath \
                --strip \
                "${BASH_SOURCE[0]}"
            )"; then
            printf \
                'Error: Unable to determine the absolute path of the program.\n' \
                1>&2
            exit 1
        fi
        script_dir="${script%/*}"
        script_filename="${script##*/}"
        script_name="${script_filename%%.*}"
    }
fi
# Convenience variables may not need to be referenced
# shellcheck disable=SC2034
{
    script_basecommand="${0}"
    script_args=("${@}")
}

# FALSE POSITIVE: Trap handlers are not invoked directly
# shellcheck disable=SC2329
trap_err(){
    printf \
        'Error: The program has encountered an unhandled error and is prematurely aborted.\n' \
        1>&2
}
if ! trap trap_err ERR; then
    printf \
        'Error: Unable to set the ERR trap.\n' \
        1>&2
    exit 1
fi

main "${@}"
