<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
    <xsl:output method="text" encoding="UTF-8" doctype-system="xkb.dtd"/>
    <xsl:template match="/xkbConfigRegistry">
        <xsl:text><![CDATA[.\" WARNING: this man page is autogenerated. Do not edit or you will lose all your changes.
.TH XKEYBOARD-CONFIG 7 @vendorversion@
.SH NAME
xkeyboard-config \- XKB data description files
.SH DESCRIPTION
xkeyboard-config provides the description files for the X Keyboard
Extension (XKB) and for libxkbcommon. Typically it is
the task of the desktop environment to apply the
requested configuration. Users running an X server can also use the
setxkbmap(1) tool to apply keyboard configuration at runtime or configure XKB
settings in the xorg.conf(5).

.SH XKB DATA FILES LOAD PATHS

xkeyboard-config provides the XKB data files installed in
@xkb_base@. User-specific data files may be elsewhere but it depends on
the tool whether those files are loaded. For example, the libxkbcommon
library will by default load XKB data files from the user's home directory.
See the libxkbcommon documentation for details.

.SH THE "CUSTOM" LAYOUT

The "custom" layout is a layout that is listed as available to tools
reading the data files but is not actually provided by xkeyboard-config.
A user may save a layout specification in the @xkb_base@/symbols/custom file
and that layout will be available to most tools interacting with the
xkeyboard-config data files. This is primarily aimed at systems running X
where additional lookup paths cannot easily be added.
.PP
Because the "custom" layout is merely listed as available but not
provided by xkeyboard-config, the layout will not be overwritten on updates.

.SH MODELS
.TS
nowarn,box;
lB lB
___
lB l.
Model	Description
]]></xsl:text>
        <xsl:apply-templates select="modelList"/>
        <xsl:text><![CDATA[
.TE
.SH LAYOUTS
.TS
nowarn,box;
lB lB
____
lB l.
Layout(Variant)	Description
]]></xsl:text>
        <xsl:apply-templates select="layoutList"/>
        <xsl:text><![CDATA[
.TE
.SH OPTIONS
]]></xsl:text>
        <xsl:apply-templates select="optionList"/>
        <xsl:text><![CDATA[
.SH FILES
@xkb_base@/compat

@xkb_base@/compiled

@xkb_base@/geometry

@xkb_base@/keycodes

@xkb_base@/keymap

@xkb_base@/rules

@xkb_base@/semantics

@xkb_base@/symbols

@xkb_base@/types

.SH SEE ALSO
setxkbmap(1)
]]></xsl:text>
    </xsl:template>

<!-- split model/description into a normal table -->
    <xsl:template match="modelList">
        <xsl:for-each select="model">
            <xsl:value-of select="configItem/name"/><xsl:text>&#9;</xsl:text><xsl:value-of select="configItem/description"/>
            <xsl:text>&#10;</xsl:text>
        </xsl:for-each>
    </xsl:template>

<!-- split layout/variant/description into a table like this

        layout1                 description
        layout1(variant1)       description
        layout1(variant2)       description
        layout2                 description
        layout2(variant1)       description
-->
    <xsl:template match="layoutList">
        <xsl:for-each select="layout">
            <xsl:value-of select="configItem/name"/>
            <xsl:text>&#9;</xsl:text>
            <xsl:value-of select="configItem/description"/>
            <xsl:text>&#10;</xsl:text>
            <xsl:for-each select="variantList/variant">
                <xsl:value-of select="../../configItem/name"/>
                <xsl:text>(</xsl:text>
                <xsl:value-of select="configItem/name"/>
                <xsl:text>)</xsl:text>
                <xsl:text>&#9;</xsl:text>
                <xsl:value-of select="configItem/description"/>
                <xsl:text>&#10;</xsl:text>
            </xsl:for-each>
            <xsl:text>&#10;</xsl:text>
            <xsl:text>_&#10;</xsl:text>
        </xsl:for-each>
    </xsl:template>

<!-- split option into a table like this

option description:
        optarg          description
        optarg          description
        optarg          description

option2 description:
        optarg          description
        optarg          description
-->
    <xsl:template match="optionList">
        <xsl:for-each select="group">
            <xsl:text><![CDATA[
.SS]]></xsl:text>
            <xsl:text>&#10;</xsl:text>
            <xsl:value-of select="configItem/description"/>
            <xsl:text><![CDATA[
.BR
.TS
nowarn,box;
lw25B lxB
___
lB lx.
Option	Description
]]></xsl:text>
            <xsl:for-each select="option">
                <xsl:value-of select="configItem/name"/>
                <xsl:text>&#9;T{&#10;</xsl:text>
                <xsl:value-of select="configItem/description"/>
                <xsl:text>&#10;T}&#10;</xsl:text>
            </xsl:for-each>
            <xsl:text><![CDATA[
.TE

]]></xsl:text>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
