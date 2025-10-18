#!/usr/bin/env bash
# Utility to convert user-specified YouTube playlist into a Markdown list with
# links to each video.
#
# Copyright 2024 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: AGPL-3.0-or-later

main(){
    local playlist_url="$1"; shift

    if test -z "${playlist_url}"; then
        printf 'Error: A playlist URL must be provided.\n' 1>&2
        return 1
    fi

    # References:
    #
    # * https://github.com/yt-dlp/yt-dlp#json-output
    # * https://github.com/yt-dlp/yt-dlp#flat-playlists
    local video_info
    video_info="$(
        yt-dlp \
            --flat-playlist \
            -j \
            "${playlist_url}" \
        | jq -r '"\(.title);\(.webpage_url)"'
    )"

    local title
    local url
    while IFS=';' read -r title url; do
        printf -- '* [%s](%s)\n' "${title}" "${url}"
    done <<< "${video_info}"
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
