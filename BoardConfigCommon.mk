#
# Copyright (C) 2022-2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from the proprietary version
include vendor/xiaomi/sm8450-common/BoardConfigVendor.mk

COMMON_PATH := device/xiaomi/sm8450-common

# A/B
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    odm \
    product \
    recovery \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_boot \
    vendor_dlkm

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a-branchprot
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := kryo300

# Audio
AUDIO_FEATURE_ENABLED_DLKM := true
AUDIO_FEATURE_ENABLED_DTS_EAGLE := false
AUDIO_FEATURE_ENABLED_GEF_SUPPORT := true
AUDIO_FEATURE_ENABLED_HW_ACCELERATED_EFFECTS := false
AUDIO_FEATURE_ENABLED_INSTANCE_ID := true
AUDIO_FEATURE_ENABLED_PAL_HIDL := true
AUDIO_FEATURE_ENABLED_PROXY_DEVICE := true

$(call soong_config_set,qtiaudio,feature_disabled_dts_eagle,true)
$(call soong_config_set,qtiaudio,feature_gef_support,true)
$(call soong_config_set,qtiaudio,feature_instance_id,true)
$(call soong_config_set,qtiaudio,feature_pal_hidl,true)

BOARD_SUPPORTS_OPENSOURCE_STHAL := true

TARGET_USES_QCOM_MM_AUDIO := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := taro
TARGET_NO_BOOTLOADER := true

# Build
BUILD_BROKEN_DUP_RULES := true

# Display
BUILD_DISPLAY_TECHPACK_SOURCE := true
TARGET_USES_DRM_PP := true
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true
MAX_VIRTUAL_DISPLAY_DIMENSION := 4096
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
TARGET_USES_HWC2 := true
TARGET_USES_QCOM_DISPLAY_BSP := true
TARGET_USES_COLOR_METADATA := true
TARGET_HAS_WIDE_COLOR_DISPLAY := true
TARGET_HAS_HDR_DISPLAY := true
TARGET_USES_DISPLAY_RENDER_INTENTS := true
TARGET_USE_COLOR_MANAGEMENT := true
SF_WCG_COMPOSITION_DATA_SPACE := 143261696
TARGET_USES_QTI_MAPPER_2_0 := true
TARGET_USES_QTI_MAPPER_EXTENSIONS_1_1 := true
TARGET_USES_GRALLOC4 := true

SOONG_CONFIG_NAMESPACES += qtidisplay
SOONG_CONFIG_qtidisplay := \
    drmpp \
    headless \
    llvmsa \
    gralloc4 \
    displayconfig_enabled \
    udfps \
    default \
    var1 \
    var2 \
    var3 \
    panel_dimension_extra_precision \
    sdmcore_has_is_display_hw_available_func
SOONG_CONFIG_qtidisplay_drmpp := true
SOONG_CONFIG_qtidisplay_headless := false
SOONG_CONFIG_qtidisplay_llvmsa := false
SOONG_CONFIG_qtidisplay_gralloc4 := true
SOONG_CONFIG_qtidisplay_displayconfig_enabled := true
SOONG_CONFIG_qtidisplay_udfps := false
SOONG_CONFIG_qtidisplay_default := true
SOONG_CONFIG_qtidisplay_var1 := true
SOONG_CONFIG_qtidisplay_var2 := true
SOONG_CONFIG_qtidisplay_var3 := false
SOONG_CONFIG_qtidisplay_panel_dimension_extra_precision := false
SOONG_CONFIG_qtidisplay_sdmcore_has_is_display_hw_available_func := true

# Filesystem
TARGET_FS_CONFIG_GEN := $(COMMON_PATH)/configs/config.fs

# GPS
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := default

# Kernel
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_RAMDISK_USE_LZ4 := true
BOARD_USES_GENERIC_KERNEL_IMAGE := true
TARGET_HAS_GENERIC_KERNEL_HEADERS := true

BOARD_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS := --header_version $(BOARD_BOOT_HEADER_VERSION)

BOARD_KERNEL_CMDLINE := \
    disable_dma32=on \
    mtdoops.fingerprint=$(AOSPA_VERSION) \
    swinfo.fingerprint=$(AOSPA_VERSION) \
    allow_file_spec_access \
    irqaffinity=0-3 \
    pelt=8

BOARD_BOOTCONFIG := \
    androidboot.hardware=qcom \
    androidboot.init_fatal_reboot_target=recovery \
    androidboot.memcg=1 \
    androidboot.usbcontroller=a600000.dwc3

# Metadata
BOARD_USES_METADATA_PARTITION := true

# Partitions
BOARD_USES_VENDOR_DLKMIMAGE := true
BOARD_FLASH_BLOCK_SIZE := 0x020000 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x0C000000
BOARD_DTBOIMG_PARTITION_SIZE := 0x01800000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x06400000
BOARD_SUPER_PARTITION_SIZE := 9126805504 # 0x220000000
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 0x06000000

BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := odm product system system_ext vendor vendor_dlkm
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 9122611200 # 0x21FC00000 # BOARD_SUPER_PARTITION_SIZE - overhead (4MiB)

BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4

# Free Size RW, ODM 100MB, P 500MB, S 500MB, SE 200MB, V 200MB, VD 100MB
BOARD_ODMIMAGE_PARTITION_RESERVED_SIZE := 104857600
BOARD_PRODUCTIMAGE_PARTITION_RESERVED_SIZE := 524288000
BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE := 524288000
BOARD_SYSTEM_EXTIMAGE_PARTITION_RESERVED_SIZE := 209715200
BOARD_VENDORIMAGE_PARTITION_RESERVED_SIZE := 209715200
BOARD_VENDOR_DLKMIMAGE_PARTITION_RESERVED_SIZE := 104857600

TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm

# Platform
BOARD_USES_QCOM_HARDWARE := true
TARGET_BOARD_PLATFORM := taro

# Properties
TARGET_ODM_PROP += $(COMMON_PATH)/properties/odm.prop
TARGET_PRODUCT_PROP += $(COMMON_PATH)/properties/product.prop
TARGET_SYSTEM_PROP += $(COMMON_PATH)/properties/system.prop
TARGET_SYSTEM_EXT_PROP += $(COMMON_PATH)/properties/system_ext.prop
TARGET_VENDOR_PROP += $(COMMON_PATH)/properties/vendor.prop

# Recovery
TARGET_RECOVERY_FSTAB := $(COMMON_PATH)/rootdir/etc/recovery.fstab
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true
BOARD_USES_FULL_RECOVERY_IMAGE := true

SOONG_CONFIG_NAMESPACES += ufsbsg
SOONG_CONFIG_ufsbsg += ufsframework
SOONG_CONFIG_ufsbsg_ufsframework := bsg

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

SOONG_CONFIG_NAMESPACES += rmnetctl
SOONG_CONFIG_rmnetctl += old_rmnet_data
SOONG_CONFIG_rmnetctl_old_rmnet_data := true

# Sensors
$(call soong_config_set_bool,SENSORS_XIAOMI,USES_DOUBLE_TAP_SENSOR,true)
$(call soong_config_set_bool,SENSORS_XIAOMI,USES_SINGLE_TAP_SENSOR,true)
$(call soong_config_set_bool,SENSORS_XIAOMI,USES_UDFPS_SENSOR,true)

# Sepolicy
include device/qcom/sepolicy_vndr/SEPolicy.mk

SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += $(COMMON_PATH)/sepolicy/public
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += $(COMMON_PATH)/sepolicy/private
BOARD_VENDOR_SEPOLICY_DIRS += $(COMMON_PATH)/sepolicy/vendor

# VINTF
DEVICE_MATRIX_FILE := device/qcom/vendor-common/compatibility_matrix.xml

DEVICE_MANIFEST_SKUS := taro diwali cape ukee
$(foreach sku, $(call to-upper, $(DEVICE_MANIFEST_SKUS)), \
    $(eval DEVICE_MANIFEST_$(sku)_FILES := \
        $(COMMON_PATH)/vintf/manifest.xml \
        $(COMMON_PATH)/vintf/manifest_xiaomi.xml \
        $(if $(TARGET_NFC_SUPPORTED_SKUS),$(COMMON_PATH)/vintf/manifest_no_nfc.xml,) \
    ))

ifneq ($(TARGET_NFC_SUPPORTED_SKUS),)
ODM_MANIFEST_SKUS += $(TARGET_NFC_SUPPORTED_SKUS)
$(foreach nfc_sku, $(call to-upper, $(TARGET_NFC_SUPPORTED_SKUS)), \
    $(eval ODM_MANIFEST_$(nfc_sku)_FILES += $(COMMON_PATH)/vintf/manifest_nfc.xml))
endif

DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += \
    $(COMMON_PATH)/vintf/framework_compatibility_matrix.xml \
    vendor/qcom/opensource/core-utils/vendor_framework_compatibility_matrix.xml \
    hardware/xiaomi/vintf/xiaomi_framework_compatibility_matrix.xml

# Verified Boot
ifeq ($(VENDOR_SECURITY_PATCH),)
$(error "VENDOR_SECURITY_PATCH must be set for vbmeta rollback index")
endif
BOARD_AVB_ENABLE := true
BOARD_AVB_ALGORITHM := SHA256_RSA2048
BOARD_AVB_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA2048
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1
BOARD_AVB_VBMETA_SYSTEM := system system_ext product
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(shell date -d 'TZ="GMT" $(VENDOR_SECURITY_PATCH)' +%s)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2

BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true

# WiFi
BOARD_WLAN_DEVICE := qcwcn
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := //hardware/qcom/wlan/qcwcn/wpa_supplicant_8_lib:lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := //hardware/qcom/wlan/qcwcn/wpa_supplicant_8_lib:lib_driver_cmd_$(BOARD_WLAN_DEVICE)
# (1 STA + 1 AP) or (1 STA + 1 of (P2P or NAN)) or (2 AP) or (2 STA)
WIFI_HAL_INTERFACE_COMBINATIONS := {{{STA}, 1}, {{AP}, 1}}, {{{STA}, 1}, {{P2P, NAN}, 1}}, {{{AP}, 2}}, {{{STA}, 2}}
WIFI_DRIVER_BUILT := qca_cld3
WIFI_DRIVER_DEFAULT := qca_cld3
WIFI_DRIVER_STATE_CTRL_PARAM := "/dev/wlan"
WIFI_DRIVER_STATE_OFF := "OFF"
WIFI_DRIVER_STATE_ON := "ON"
WIFI_FEATURE_HOSTAPD_11AX := true
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true
WPA_SUPPLICANT_VERSION := VER_0_8_X

# Camera
$(call soong_config_set,libcameraservice,ext_lib,//$(COMMON_PATH):libcameraservice_extension.xiaomi_taro)
TARGET_CAMERA_SERVICE_EXT_LIB := //$(COMMON_PATH):libcameraservice_extension.xiaomi_taro

# MIUI Camera
-include device/xiaomi/miuicamera-ingres/BoardConfig.mk
