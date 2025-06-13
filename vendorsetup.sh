#!/bin/bash

fox_dir=$(pwd)

inject_self_repacker(){
    file="$fox_dir/bootable/recovery/twrpRepacker.cpp"

    # Create a temporary file with the C++ code to inject using a here-document
    cat << 'EOF_CODE_TO_INJECT' > /tmp/repacker_code_to_inject.cpp
if (TWFunc::Path_Exists("/system/bin/reflash_twrp.sh")) {
    gui_print("- Starting suctom reflash recovery script\\n");
    int pipe_fd[2];
    if (pipe(pipe_fd) == -1) {
        LOGERR("Failed to create pipe");
        return false;
    }
    if (TWFunc::Path_Exists("/system/bin/reflash_twrp.sh")) {
        std::string command = "/system/bin/reflash_twrp.sh " + std::to_string(pipe_fd[1]) + " " + std::to_string(pipe_fd[0]);
        gui_print("- Reflashing recovery\\n");
        int result = TWFunc::Exec_Cmd(command);
        if (result != 0) {
            LOGERR("Script reflash_twrp.sh failed with error code: %d", result);
            gui_print_color("error", "Script reflash_twrp.sh failed with error code: %d\\n", result);
            return false;
        }
        gui_print_color("green", "- Successfully flashed recovery to both slots\\n");
        close(pipe_fd[0]);
        close(pipe_fd[1]);
        return true;
    }
    return false;
}
EOF_CODE_TO_INJECT

    # Проверка, существует ли файл
    if [ ! -f "$file" ]; then
        echo "Файл не найден: $file"
        exit 1
    fi
    if grep -q "bool twrpRepacker::Flash_Current_Twrp()" "$file"; then
        echo "Функция twrpRepacker::Flash_Current_Twrp() найдена в файле"
        if ! grep -q "if (TWFunc::Path_Exists(\"/system/bin/reflash_twrp.sh\"))" "$file"; then
            echo "Вставляем код в функцию twrpRepacker::Flash_Current_Twrp()"
            # Use 'r' command to read and insert from the temporary file
            sed -i "/bool twrpRepacker::Flash_Current_Twrp() {/r /tmp/repacker_code_to_inject.cpp" "$file"
            echo "Код успешно вставлен."
        else
            echo "Код уже присутствует в функции twrpRepacker::Flash_Current_Twrp()."
        fi
    else
        echo "Функция twrpRepacker::Flash_Current_Twrp() не найдена в файле."
        exit 1
    fi

    # Clean up temporary file
    rm /tmp/repacker_code_to_inject.cpp
}

inject_self_repacker

sed -i 's/ || defined(RECOVERY_ABGR)//g' $fox_dir/bootable/recovery/minuitwrp/graphics.cpp
sed -i 's/ || defined(RECOVERY_ABGR)//g' $fox_dir//bootable/recovery/minuitwrp/resources.cpp

#set -o xtrace
export FOX_VENDOR_BOOT_RECOVERY=1
export ALLOW_MISSING_DEPENDENCIES=true
FDEVICE="shusky" # Keep this if it's supposed to be shusky here

if [ -d "$fox_dir/vendor/pb" ] ; then
    export BUILD_VATIANT_SELF=PB
else
    export BUILD_VATIANT_SELF=FOX
fi
echo "BUILD_VATIANT_SELF=${BUILD_VATIANT_SELF}"
export TARGET_DEVICE_ALT="Pixel8, GooglePixel8, Akita, AKITA, akita, GooglePixel8a, Pixel8a, Pixel 8a, pixel8a, googlepixel8a"
if [ $BUILD_VATIANT_SELF == FOX ] ; then
    export FOX_VERSION="R12.1"
    export FOX_USE_SPECIFIC_MAGISK_ZIP=$fox_dir/device/google/shusky/included-stuff/Magisk/Magisk-v28.0.zip
    export FOX_VANILLA_BUILD=1
    export FOX_ENABLE_APP_MANAGER=1
    export FOX_VIRTUAL_AB_DEVICE=1
    export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
    export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
    export FOX_USE_BASH_SHELL=1
    export FOX_ASH_IS_BASH=1
    export FOX_USE_TAR_BINARY=1
    export FOX_USE_XZ_UTILS=1
    export FOX_USE_LZ4_BINARY=1
    export FOX_DELETE_AROMAFM=1
    # IMPORTANT: You have TARGET_DEVICE_ALT defined twice. The second one will override.
    # Ensure 'akita' is the final intended value if you want it to be akita.
    export TARGET_DEVICE_ALT="akita"

    # instruct magiskboot v24+ to always patch the vbmeta header when patching the recovery/boot image; do *not* remove!
    export FOX_PATCH_VBMETA_FLAG="1"
fi

echo 'FUCK'
export | grep FOX
export | grep OF_
export | grep TARGET_
export | grep TW_

export | grep _VERSION
export | grep _API_LEVEL
# export FOX_BUGGED_AOSP_ARB_WORKAROUND="1601559499"

# export OF_QUICK_BACKUP_LIST="/boot;/init_boot;/vendor_boot;/vendor_kernel_boot"

# # Magisk\\wsl.localhost\Fedora\home\leegar\fox_12.1\device\google\shusky\vendorsetup.sh
# # \\wsl.localhost\Fedora\home\leegar\fox_12.1\device\google\shusky\included-staff\Magisk\Magisk-v28.0.zip
# 

# # Don't install AromaFM
# export FOX_DELETE_AROMAFM=1

# # Add some extras
# export FOX_USE_ZIP_BINARY=1
# export FOX_USE_TAR_BINARY=1
# export FOX_USE_SED_BINARY=1
# export FOX_USE_XZ_UTILS=1
# export FOX_USE_LZ4_BINARY=1
# export FOX_USE_ZSTD_BINARY=1
# # export FOX_ASH_IS_BASH=1
# export FOX_REPLACE_BUSYBOX_PS=1
# # export FOX_USE_BASH_SHELL=1
# export OF_USE_LZ4_COMPRESSION=1 
# export FOX_USE_NANO_EDITOR=0
# export OF_DONT_KEEP_LOG_HISTORY=1
# export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES=0
# export FOX_INSTALLER_DISABLE_AUTOREBOOT=1
# export OF_DISABLE_MIUI_SPECIFIC_FEATURES=1
# export OF_ENABLE_FS_COMPRESSION=1
# export FOX_REPLACE_TOOLBOX_GETPROP=1
# # export FOX_BASH_TO_SYSTEM_BIN=1
# # export FOX_ENABLE_APP_MANAGER=1
# export FOX_VARIANT="default"
# export OF_USE_GREEN_LED=1
# export ALLOW_MISSING_DEPENDENCIES=true
echo 'FUCK'
export | grep FOX
export | grep OF_
export | grep TARGET_
export | grep TW_

export | grep _VERSION
export | grep _API_LEVEL
