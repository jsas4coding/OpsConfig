#!/usr/bin/env bash
# =============================================================================
# OpsConfig Common Library
# =============================================================================
# Shared constants and functions for all OpsConfig scripts.
# Source this file: source "$(dirname "$0")/lib/common.sh"
# =============================================================================

readonly OPSCONFIG_VERSION="3.0.5"

# =============================================================================
# COLORS
# =============================================================================

readonly RED="\e[31m"
readonly GREEN="\e[32m"
readonly YELLOW="\e[33m"
readonly CYAN="\e[36m"
readonly WHITE="\e[97m"
readonly MAGENTA="\e[35m"
readonly NC="\e[0m"
readonly RESET="${NC}"

# =============================================================================
# ICONS
# =============================================================================

readonly SUCCESS_ICON="[OK] "
readonly ERROR_ICON="[ERR] "
readonly WARNING_ICON="[WARN] "
readonly INFO_ICON="[INFO] "

# =============================================================================
# LOGGING
# =============================================================================

msg() {
  local type="$1"
  local text="$2"
  local icon=""
  local color=""

  case "$type" in
    success)
      icon="$SUCCESS_ICON"
      color="$GREEN"
      ;;
    error)
      icon="$ERROR_ICON"
      color="$RED"
      ;;
    warning)
      icon="$WARNING_ICON"
      color="$YELLOW"
      ;;
    info)
      icon="$INFO_ICON"
      color="$CYAN"
      ;;
    download)
      icon="[DL] "
      color="$WHITE"
      ;;
    delete)
      icon="[DEL] "
      color="$RED"
      ;;
    git)
      icon="[GIT] "
      color="$MAGENTA"
      ;;
    config)
      icon="[CFG] "
      color="$CYAN"
      ;;
    clean)
      icon="[CLN] "
      color="$MAGENTA"
      ;;
    php)
      icon="[PHP] "
      color="$MAGENTA"
      ;;
    migrate)
      icon="[MIG] "
      color="$MAGENTA"
      ;;
    *)
      icon=" "
      color="$WHITE"
      ;;
  esac

  echo -e "${color}${icon}${text}${NC}"
}
