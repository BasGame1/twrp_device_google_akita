#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#




DEVICE_PATH := device/google/akita

BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
TARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/pixel-stuff/board-info.txt
TARGET_SUPPORTS_64_BIT_APPS := true
TARGET_IS_64_BIT := true
TARGET_USES_LOGD := true

AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += boot
AB_OTA_PARTITIONS += init_boot
AB_OTA_PARTITIONS += vendor_boot
AB_OTA_PARTITIONS += dtbo
AB_OTA_PARTITIONS += vbmeta
AB_OTA_PARTITIONS += vbmeta_system
AB_OTA_PARTITIONS += vbmeta_vendor
AB_OTA_PARTITIONS += product
AB_OTA_PARTITIONS += system
AB_OTA_PARTITIONS += system_ext
AB_OTA_PARTITIONS += system_dlkm
AB_OTA_PARTITIONS += vendor
AB_OTA_PARTITIONS += vendor_dlkm
AB_OTA_PARTITIONS += modem
AB_OTA_PARTITIONS += vendor_kernel_boot
AB_OTA_PARTITIONS += tzsw
AB_OTA_PARTITIONS += idfw
AB_OTA_PARTITIONS += abl
AB_OTA_PARTITIONS += pvmfw
AB_OTA_PARTITIONS += bl2
AB_OTA_PARTITIONS += gsa
AB_OTA_PARTITIONS += bl31
AB_OTA_PARTITIONS += pbl
AB_OTA_PARTITIONS += gsa_bl1
AB_OTA_PARTITIONS += bl1
AB_OTA_PARTITIONS += gcf



TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a
TARGET_CPU_VARIANT := cortex-a55
TARGET_CPU_VARIANT_RUNTIME := cortex-a55
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=

PRODUCT_PLATFORM := zuma

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armv8-2a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a75
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a75
TARGET_BOOTLOADER_BOARD_NAME := $(PRODUCT_PLATFORM)
TARGET_NO_BOOTLOADER := true

TARGET_USES_UEFI := true

TARGET_BOARD_PLATFORM := $(GOOGLE_BOARD_PLATFORMS)
TARGET_BOARD_PLATFORM_GPU := mali-g71
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_CLANG_COMPILE   := true
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image.lz4

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_COPY_OUT_VENDOR := vendor

TARGET_RECOVERY_PIXEL_FORMAT := ABGR_8888

# TARGET_RECOVERY_PIXEL_FORMAT := RGB_565 Nont booted
# TARGET_RECOVERY_PIXEL_FORMAT := ABGR_8888 Uses, But orange its Blues, cute
# TARGET_RECOVERY_PIXEL_FORMAT := ARGB_8888 Not useles, black screen
# TARGET_RECOVERY_PIXEL_FORMAT := RGBA_8888 Not useles black screen
# TARGET_RECOVERY_PIXEL_FORMAT := BGRA_8888 Not useles EXTRAAA GREEEN
# TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888" Not useles EXTRAAA ORANGE

TARGET_SYSTEM_PROP += $(DEVICE_PATH)/included-stuff/system.prop
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/included-stuff/recovery.fstab
TARGET_RECOVERY_WIPE := $(DEVICE_PATH)/included-stuff/recovery.wipe

VENDOR_CMDLINE := "dyndbg=\"func alloc_contig_dump_pages +p\" \
        earlycon=exynos4210,0x10A00000 \
        console=ttySAC0,115200 \
        androidboot.console=ttySAC0 \
        printk.devkmsg=on \
        swiotlb=noforce \
        cma_sysfs.experimental=Y \
        cgroup_disable=memory \
        rcupdate.rcu_expedited=1 \
        rcu_nocbs=all \
        stack_depot_disable=off \
        page_pinner=on \
        swiotlb=1024 \
        disable_dma32=on \
        at24.write_timeout=100 \
        log_buf_len=1024K \
        bootconfig"

BOARD_BOOTCONFIG += androidboot.boot_devices=13200000.ufs
BOARD_BOOTCONFIG += androidboot.load_modules_parallel=true

BOARD_FLASH_BLOCK_SIZE := 131072


BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864

BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

BOARD_USES_RECOVERY_AS_BOOT := false
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_USES_GENERIC_KERNEL_IMAGE := true
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true


BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_PREBUILT_DTBIMAGE_DIR := $(DEVICE_PATH)/prebuilt/dtbs
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbs/dtbo.img


BOARD_KERNEL_PAGESIZE    := 2048
BOARD_BOOT_HEADER_VERSION := 4
BOARD_KERNEL_BASE        := 0x1000000
BOARD_KERNEL_OFFSET      := 0x00008000
BOARD_RAMDISK_OFFSET     := 0x01000000
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_DTB_OFFSET         := 0x01f00000
BOARD_KERNEL_IMAGE_NAME := Image.lz4
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --vendor_cmdline $(VENDOR_CMDLINE)

BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true
BOARD_AVB_ENABLE := true
BOARD_SUPER_PARTITION_SIZE := 8531214336
BOARD_SUPER_PARTITION_GROUPS := google_dynamic_partitions
BOARD_GOOGLE_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext product vendor vendor_dlkm product #
BOARD_GOOGLE_DYNAMIC_PARTITIONS_SIZE := 8527020032


BOARD_HAS_LARGE_FILESYSTEM := true


TW_EXCLUDE_APEX := true
ALLOW_MISSING_DEPENDENCIES := true
ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

TARGET_USES_MKE2FS := true
RECOVERY_SDCARD_ON_DATA := true
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel/brightness"
TW_MAX_BRIGHTNESS := 3827
TW_DEFAULT_BRIGHTNESS := 219
TWRP_INCLUDE_LOGCAT := true
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_FASTBOOTD := true
TW_THEME := portrait_hdpi
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_INCLUDE_NTFS_3G := true
TW_USE_TOOLBOX := true
TW_INCLUDE_FUSE_EXFAT := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_EXTRA_LANGUAGES := true
TW_DEFAULT_LANGUAGE := en
TW_LOAD_VENDOR_MODULES := fips140.ko zsmalloc.ko drm_display_helper.ko at24.ko open-dice.ko sg.ko spidev.ko i2c-dev.ko arm-cmn.ko phy-exynos-usbdrd-eusb-super.ko eusb_repeater.ko phy-exynos-mipi-dsim.ko phy-exynos-mipi.ko pinctrl-exynos-gs.ko pcie-exynos-gs.ko pcie-exynos-zuma-rc-cal.ko clk_exynos_gs.ko pl330.ko samsung-dma.ko dss.ko debug-snapshot-debug-kinfo.ko ehld.ko exynos-debug-test.ko pixel-debug-test.ko itmon.ko bookerci.ko exynos-coresight.ko exynos-ecc-handler.ko exynos-coresight-etm.ko exynos-adv-tracer.ko exynos-adv-tracer-s2d.ko pixel-boot-metrics.ko pixel-suspend-diag.ko sjtag-driver.ko etm2dram.ko vh_sched.ko sched_tp.ko systrace.ko vh_fs.ko vh_mm.ko vh_cgroup.ko pixel_em.ko vh_thermal.ko pixel_metrics.ko gs-chipid.ko cmupmucal.ko exynos-pmu-if.ko exynos-cpuhp.ko exynos-pd.ko exynos-pd-dbg.ko exynos-pd_el3.ko exynos-pd_hsi0.ko exynos-pm.ko exynos-cpupm.ko ect_parser.ko gs_acpm.ko acpm_flexpmu_dbg.ko power_stats.ko exynos-dm.ko exynos_pm_qos.ko slc_pt.ko slc_dummy.ko slc_acpm.ko slc_pmon.ko gsa.ko gsa_gsc.ko tzprot.ko exynos-bcm_dbg-dump.ko gnss_spi.ko gnssif.ko eh.ko gcma.ko hardlockup-debug.ko hardlockup-watchdog.ko pixel_stat_sysfs.ko pixel_stat_mm.ko pkvm-s2mpu-v9.ko perf_trace_counters.ko kernel-top.ko google_modemctl.ko pmic_class.ko s2mpg14-regulator.ko s2mpg14-powermeter.ko s2mpg15-regulator.ko s2mpg15-powermeter.ko slg51002-regulator.ko rt6160-regulator.ko exynos_tty.ko samsung-iommu-group.ko samsung-secure-iova.ko iovad-vendor-hooks.ko samsung_iommu_v9.ko exynos-pcie-iommu.ko g2d.ko s5910.ko sbb-mux.ko sscoredump.ko s2mpg14-mfd.ko s2mpg15-mfd.ko s2mpg1415-gpio.ko slg51002-core.ko samsung_dma_heap.ko ufs-exynos-gs.ko ufs-pixel-fips140.ko spi-s3c64xx.ko spmi_bit_bang.ko dwc3-exynos-usb.ko xhci-exynos.ko xhci-goog-dma.ko usb_f_dm.ko usb_f_dm1.ko usb_f_etr_miu.ko google_tcpci_shim.ko usb_psy.ko tcpci_max77759.ko max77759_helper.ko bc_max77759.ko max777x9_contaminant.ko max77759_contaminant.ko max77779_contaminant.ko usbc_cooling_dev.ko s2mpg14-key.ko keycombo.ko keydebug.ko rtc-s2mpg14.ko i2c-exynos5.ko i2c-acpm.ko exynos_mfc.ko smfc.ko debug-reboot.ko gs_thermal.ko gpu_cooling.ko s2mpg15_spmic_thermal.ko s3c2410_wdt.ko exynos-acme.ko exynos_mct_v3.ko exynos_devfreq.ko gs_perf_mon.ko gs_governor_memlat.ko gs_governor_utils.ko gs_governor_dsulat.ko odpm.ko bts.ko zram_gs.ko zcomp_cpu.ko zcomp_eh.ko audiometrics.ko aoc_core.ko aoc_tbn_service_dev.ko aoc_alsa_dev_util.ko aoc_usb_driver.ko google-bms.ko google-battery.ko google-charger.ko google-cpm.ko max77729-pmic.ko max77759-charger.ko max77779-charger.ko max77779-charger-i2c.ko max77779-vimon.ko max77779-vimon-i2c.ko p9221.ko pca9468.ko max1720x-battery.ko max77779-fg.ko max77779-fg-i2c.ko max20339.ko max77779-sp.ko max77779-sp-i2c.ko max77779_i2cm.ko max77779_i2cm_i2c.ko max77779_pmic.ko max77779_pmic_irq.ko max77779_pmic_pinctrl.ko max77779_pmic_sgpio.ko max77779_pmic_i2c.ko ln8411.ko gvotable.ko logbuffer.ko gs-drm-connector.ko gs-panel.ko panel-common.ko panel-samsung-drv.ko panel-samsung-emul.ko panel-samsung-s6e3hc2.ko panel-samsung-s6e3fc3.ko panel-samsung-s6e3fc3-p10.ko panel-samsung-sofef01.ko panel-samsung-s6e3hc3.ko panel-samsung-s6e3hc3-c10.ko panel-samsung-s6e3hc4.ko exynos-drm.ko exynos-drm-audio.ko mali_kbase.ko mali_pixel.ko exynos-hdcp2.ko google_bcl.ko pixel-reboot.ko trusty-core.ko trusty-log.ko trusty-test.ko trusty-virtio.ko trusty-ipc.ko bigwave.ko panel-google-ak3a.ko panel-google-ak3b.ko bcm47765.ko st21nfc.ko st54spi.ko shm_ipc.ko cpif_page.ko cpif.ko touch_bus_negotiator.ko touch_offload.ko
TW_LOAD_VENDOR_DLKM_MODULES := $(TW_LOAD_VENDOR_MODULES)
TW_LOAD_VENDOR_MODULES_EXCLUDE_GKI := true
TW_FRAMERATE := 120
TW_USE_SAMSUNG_HAPTICS := true
TWRP_EVENT_LOGGING := true
TW_INCLUDE_LIBRESETPROP := true
TW_INCLUDE_LPTOOLS := true
TW_CUSTOM_CPU_TEMP_PATH := "/sys/class/thermal/thermal_zone48/temp"
TW_BATTERY_SYSFS_WAIT_SECONDS := 6
SELINUX_IGNORE_NEVERALLOWS := true
BOARD_RAMDISK_USE_LZ4 := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file
TARGET_SCREEN_WIDTH := 1344
TARGET_SCREEN_HEIGHT := 2992

BOARD_VENDOR := google
TARGET_OTA_ASSERT_DEVICE := akita
GOOGLE_BOARD_PLATFORMS += zuma

TARGET_NO_RECOVERY := true
LC_ALL := C
BOARD_ROOT_EXTRA_FOLDERS := bluetooth dsp firmware persist
BOARD_SUPPRESS_SECURE_ERASE := true
BUILD_BROKEN_USES_NETWORK := true
TW_NO_SCREEN_BLANK := true
TW_INCLUDE_PYTHON := true
TW_VERSION := LeeGarChat

ifeq ($(BUILD_VATIANT_SELF),PB)
    PB_DISABLE_DEFAULT_DM_VERITY := true
    # TARGET_SOC := zuma
    # TARGET_SOC_NAME := google
    # TARGET_SCREEN_DENSITY := 480
    # TARGET_USES_VULKAN := true
    # TARGET_KERNEL_DTBO_PREFIX := dts/
    # TARGET_KERNEL_DTBO := google-devices/shusky/dtbo.img
    # TARGET_KERNEL_CONFIG := gki_defconfig
    # TARGET_RECOVERY_UI_MARGIN_HEIGHT := 165
    # TARGET_RECOVERY_UI_LIB := librecovery_ui_pixel
    # TARGET_RUNNING_WITHOUT_SYNC_FRAMEWORK := false
    # TARGET_USES_HWC2 := true
    
    # USES_DEVICE_GOOGLE_ZUMA := true
    # USES_DEVICE_GOOGLE_$(DEVICE_CODENAME) := true
    # USES_DEVICE_GOOGLE_SHUSKY := true
    # ZYGOTE_FORCE_64 := true
    # IGNORE_PREFER32_ON_DEVICE := true
    # DEXPREOPT_GENERATE_APEX_IMAGE := true
    # BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
    # BOARD_KERNEL_CMDLINE += exynos_drm.load_sequential=1
    # BOARD_EGL_CFG := $(DEVICE_PATH)/conf/egl.cfg
    # BOARD_EMULATOR_COMMON_MODULES := liblight
    # BOARD_VENDOR_KERNEL_MODULES_LOAD_RAW := $(strip $(shell cat $(DEVICE_PATH)/pixel-stuff/vendor_dlkm.modules.load))
    # BOARD_VENDOR_KERNEL_MODULES_LOAD := $(foreach m,$(BOARD_VENDOR_KERNEL_MODULES_LOAD_RAW),$(notdir $(m)))
    # BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD_RAW := $(strip $(shell cat $(DEVICE_PATH)/pixel-stuff/vendor_kernel_boot.modules.load))
    # BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(foreach m,$(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD_RAW),$(notdir $(m)))
    # BOARD_HWC_VERSION := hwc3
    # BOARD_HDMI_INCAPABLE := true
    # BOARD_USES_EXYNOS_AFBC_FEATURE := true
    # BOARD_LIBACRYL_DEFAULT_COMPOSITOR := fimg2d_zuma
    # BOARD_LIBACRYL_G2D_HDR_PLUGIN := libacryl_hdr_plugin
    # BOARD_USES_HWC_SERVICES := true
    # BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
    # BOARD_AVB_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
    # BOARD_AVB_BOOT_ALGORITHM := SHA256_RSA2048
    # BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 2
    # BOARD_AVB_INIT_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
    # BOARD_AVB_INIT_BOOT_ALGORITHM := SHA256_RSA2048
    # BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX_LOCATION := 4
    # BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
    # BOARD_PARTITION_LIST := $(call to-upper, $(BOARD_GOOGLE_DYNAMIC_PARTITIONS_PARTITION_LIST))
    # $(foreach p, $(BOARD_PARTITION_LIST), $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := erofs))
    # $(foreach p, $(BOARD_PARTITION_LIST), $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))
    # BOOT_KERNEL_MODULES := $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD)
    # HWC_SUPPORT_RENDER_INTENT := true
    # HWC_SUPPORT_COLOR_TRANSFORM := true
    
    # PB_TORCH_PATH := "/sys/devices/virtual/devlink/platform:10840000.pinctrl--platform:flash@0"
    # PB_TORCH_MAX_BRIGHTNESS := 1


    # TW_OVERRIDE_SYSTEM_PROPS := "ro.bootimage.build.date.utc=ro.build.date.utc;ro.build.date.utc;ro.odm.build.date.utc=ro.build.date.utc;ro.product.build.date.utc=ro.build.date.utc;ro.system.build.date.utc=ro.build.date.utc;ro.system_ext.build.date.utc=ro.build.date.utc;ro.vendor.build.date.utc=ro.build.date.utc;ro.build.product;ro.build.fingerprint=ro.system.build.fingerprint;ro.build.version.incremental;ro.product.name=ro.product.system.name"
    # TW_INCLUDE_FUSE_NTFS := true
    # TW_USE_SERIALNO_PROPERTY_FOR_DEVICE_ID := true

    # TW_BACKUP_EXCLUSIONS := /data/fonts
    
else
    BOARD_BUILD_SYSTEM_ROOT_IMAGE := false
endif






