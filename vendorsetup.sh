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
FDEVICE="akita" # Keep this if it's supposed to be shusky here

if [ -d "$fox_dir/vendor/pb" ] ; then
    export BUILD_VATIANT_SELF=PB
else
   export BUILD_VATIANT_SELF=OFOX
fi
echo "BUILD_VATIANT_SELF=${BUILD_VATIANT_SELF}"
export TARGET_DEVICE_ALT="Pixel8, GooglePixel8, Akita, AKITA, akita, GooglePixel8a, Pixel8a, Pixel 8a, pixel8a, googlepixel8a"
if [ $BUILD_VATIANT_SELF == "OFOX" ] ; then
    export FOX_VERSION="R12.1"
    export FOX_USE_SPECIFIC_MAGISK_ZIP=$fox_dir/device/google/akita/included-stuff/Magisk/Magisk-v28.0.zip
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
    export TARGET_DEVICE_ALT="akita"

    # instruct magiskboot v24+ to always patch the vbmeta header when patching the recovery/boot image; do *not* remove!
    export FOX_PATCH_VBMETA_FLAG="1"
fi

echo 'Look, Mom. Im on the internet'
export | grep FOX
export | grep OF_
export | grep TARGET_
export | grep TW_

export | grep _VERSION
export | grep _API_LEVEL
