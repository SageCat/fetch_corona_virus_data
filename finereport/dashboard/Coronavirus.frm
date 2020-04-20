<?xml version="1.0" encoding="UTF-8"?>
<Form xmlVersion="20170720" releaseVersion="10.0.0">
<TableDataMap>
<TableData name="newest_world_confirmed" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[CoronaVirus]]></DatabaseName>
</Connection>
<Query>
<![CDATA[SELECT confirmedCount,
       world.country_full_name,
       map_country_name
FROM (SELECT confirmedCount,
             country_full_name
      FROM world_now) world
         left join
     (select country_full_name,
             map_country_name
      from dim_country) dim
     on world.country_full_name = dim.country_full_name]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="trend@country_name" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="country_name"/>
<O>
<![CDATA[]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[CoronaVirus]]></DatabaseName>
</Connection>
<Query>
<![CDATA[SELECT sum(confirmedCount)        confirmedCount,
       sum(curedCount)            curedCount,
       sum(currentConfirmedCount) currentConfirmedCount,
       sum(currentConfirmedIncr)  currentConfirmedIncr,
       sum(deadCount)             deadCount,
       data_date
FROM (SELECT country_name_EN,
             confirmedCount,
             curedCount,
             currentConfirmedCount,
             currentConfirmedIncr,
             deadCount,
             date_format(dateId, '%m-%d') as data_date
      FROM history_data) history
         left join (select country_full_name,
                           map_country_name
                    from dim_country) dim
                   on history.country_name_EN = dim.country_full_name
where 1 = 1
    ${if(len(country_name) == 0, "", "and map_country_name ='" + country_name +"'")}
group by data_date
order by data_date]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="bar_charts" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[CoronaVirus]]></DatabaseName>
</Connection>
<Query>
<![CDATA[SELECT case
           when country_full_name = 'United States of America'
               then 'USA'
           when country_full_name = 'The United Kingdom'
               then 'UK'
           else country_full_name
           end                country_full_name,
       sum(confirmedCount) as confirmedCount,
       sum(curedCount)     as curedCount,
       sum(deadCount)      as deadCount
FROM world_now
group by country_full_name
order by confirmedCount desc
limit 10]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="detail_list" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[CoronaVirus]]></DatabaseName>
</Connection>
<Query>
<![CDATA[SELECT country_full_name,
       sum(confirmedCount) as confirmedCount,
       sum(curedCount)     as curedCount,
       sum(deadCount)      as deadCount
FROM world_now
group by country_full_name
order by confirmedCount desc]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="number_cards" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[CoronaVirus]]></DatabaseName>
</Connection>
<Query>
<![CDATA[SELECT sum(confirmedCount) as confirmedCount,
       sum(curedCount) as curedCount,
       sum(deadCount) as deadCount
FROM world_now]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="pie_chart" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[CoronaVirus]]></DatabaseName>
</Connection>
<Query>
<![CDATA[SELECT country_full_name,
       sum(confirmedCount) as confirmedCount,
       sum(curedCount)     as curedCount,
       sum(deadCount)      as deadCount
FROM world_now
group by country_full_name
order by confirmedCount desc
limit 50]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="china_data" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[CoronaVirus]]></DatabaseName>
</Connection>
<Query>
<![CDATA[SELECT China_now.province,
       currentConfirmedCount,
       confirmedCount,
       curedCount,
       deadCount,
       map_province_name
FROM China_now
left join dim_china_province
on China_now.province = dim_china_province.province]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="world_now_map" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[CoronaVirus]]></DatabaseName>
</Connection>
<Query>
<![CDATA[SELECT now.country_full_name,
       now.country,
       currentConfirmed,
       map_country_name
FROM (SELECT country_full_name,
             country,
             sum(confirmedCount - curedCount - deadCount) as currentConfirmed
      FROM world_now
      group by country_full_name, country) now
         left join (select * from dim_country) dim
on now.country = dim.country
order by currentConfirmed desc]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="effected_number" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[CoronaVirus]]></DatabaseName>
</Connection>
<Query>
<![CDATA[SELECT count(distinct country) number
FROM world_now]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="update_time" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[CoronaVirus]]></DatabaseName>
</Connection>
<Query>
<![CDATA[SELECT update_date
FROM China_history_data
limit 1]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
</TableDataMap>
<FormMobileAttr>
<FormMobileAttr refresh="false" isUseHTML="false" isMobileOnly="false" isAdaptivePropertyAutoMatch="false" appearRefresh="false" promptWhenLeaveWithoutSubmit="false" allowDoubleClickOrZoom="true"/>
</FormMobileAttr>
<Parameters/>
<Layout class="com.fr.form.ui.container.WBorderLayout">
<WidgetName name="form"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="form" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<ShowBookmarks showBookmarks="true"/>
<Center class="com.fr.form.ui.container.WFitLayout">
<WidgetName name="body"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WAbsoluteBodyLayout">
<WidgetName name="body"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Background name="ColorBackground" color="-16777216"/>
<Alpha alpha="0.9"/>
</Border>
<Background name="ColorBackground" color="-16777216"/>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="word cloud"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="chart1" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ChartEditor">
<WidgetName name="word cloud"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="Default" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-39322"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[="Deaths TOP 10 Countries"]]></Attributes>
</O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Microsoft YaHei" style="0" size="112" foreground="-1"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="true" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.wordcloud.VanChartWordCloudPlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="4" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipNameFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="4" visible="false"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0" isHighlight="true"/>
<Attr4VanChartScatter>
<Type rangeLegendType="0"/>
</Attr4VanChartScatter>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="1"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="true"/>
<ColorList>
<OColor colvalue="-39322"/>
<OColor colvalue="-11184811"/>
<OColor colvalue="-4363512"/>
<OColor colvalue="-52429"/>
<OColor colvalue="-6750208"/>
<OColor colvalue="-10331231"/>
<OColor colvalue="-7763575"/>
<OColor colvalue="-6514688"/>
<OColor colvalue="-16744620"/>
<OColor colvalue="-6187579"/>
<OColor colvalue="-15714713"/>
<OColor colvalue="-945550"/>
<OColor colvalue="-4092928"/>
<OColor colvalue="-13224394"/>
<OColor colvalue="-12423245"/>
<OColor colvalue="-10043521"/>
<OColor colvalue="-406154"/>
<OColor colvalue="-13031292"/>
<OColor colvalue="-16732559"/>
<OColor colvalue="-7099690"/>
<OColor colvalue="-11991199"/>
<OColor colvalue="-331445"/>
<OColor colvalue="-6991099"/>
<OColor colvalue="-16686527"/>
<OColor colvalue="-9205567"/>
<OColor colvalue="-7397856"/>
<OColor colvalue="-406154"/>
<OColor colvalue="-2712831"/>
<OColor colvalue="-4737097"/>
<OColor colvalue="-11460720"/>
<OColor colvalue="-6696775"/>
<OColor colvalue="-3685632"/>
</ColorList>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<VanChartWordCloudPlotAttr minrotation="0.0" maxrotation="0.0" autofontsize="false" minfontsize="10.0" maxfontsize="60.0" shapetype="0"/>
<FRFont name="Microsoft YaHei" style="0" size="72"/>
</Plot>
<ChartDefinition>
<WordCloudTableDefinition name="" wordname="country_full_name" wordvalue="deadCount" function="com.fr.data.util.function.NoneFunction">
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[bar_charts]]></Name>
</TableData>
</WordCloudTableDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="ee3d4047-c0fa-4206-a8e6-623c02a37bb8"/>
<tools hidden="true" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipNameFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
<ChartMobileAttrProvider zoomOut="0" zoomIn="2" allowFullScreen="true" functionalWhenUnactivated="false"/>
<MobileChartCollapsedStyle class="com.fr.form.ui.mobile.MobileChartCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
</MobileChartCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="200" height="129"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<body class="com.fr.form.ui.ChartEditor">
<WidgetName name="word cloud"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="Default" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[New Chart Title]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Microsoft YaHei" style="0" size="128" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.wordcloud.VanChartWordCloudPlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="4" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipNameFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="4" visible="true"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0" isHighlight="true"/>
<Attr4VanChartScatter>
<Type rangeLegendType="0"/>
</Attr4VanChartScatter>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="0"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="false"/>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<VanChartWordCloudPlotAttr minrotation="0.0" maxrotation="0.0" autofontsize="true" minfontsize="10.0" maxfontsize="100.0" shapetype="0"/>
<FRFont name="Microsoft YaHei" style="0" size="72"/>
</Plot>
</Chart>
<UUID uuid="6a6bb2d8-ab82-4092-a5f8-5f63c88d7773"/>
<tools hidden="true" sort="false" export="true" fullScreen="true"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipNameFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
<ChartMobileAttrProvider zoomOut="0" zoomIn="2" allowFullScreen="true" functionalWhenUnactivated="false"/>
<MobileChartCollapsedStyle class="com.fr.form.ui.mobile.MobileChartCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
</MobileChartCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="501" width="360" height="216"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="Title"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="report0" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="Title"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="1" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[1104900,1219200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="10" rs="2" s="0">
<O>
<![CDATA[Analysis of Novel Coronavirus Outbreak in the world]]></O>
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style horizontal_alignment="0" vertical_alignment="3" imageLayout="4">
<FRFont name="Microsoft YaHei UI" style="1" size="112" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G'A;eME*lTTI"3s0UW[^ABSYq=_(1K4sOYM?8I/F/+&/FB<=C=8F86jFGU*uZ94e]Ar&)<O
,Q1#R\$N8erGl=PGTYKZl8f7eqiO+^uR.9[+kK#k@%=2n<uCOQpNJRiN]A2o=uG1&)9,4a#Un
UcL7:phN[t$,OG^H/U;$d]AQl_Dqen.&12l%,oB4Bq42LY4,lcnD$?+.XQhA_ZQX>,_kMah)%
HW@'J$t3eFWo61FOuh`L[cHL:q\rOIEMH4lRTqM^#\!XaEV=aog^r3(-fHXA(<)D21rpkI(]A
(8>\tG=9\eoK,^_;lGkanjB#<8m7cRX`3JO4g`>RN-KYAM,B.-2<j[smK+AkqU#q%"U.h`,A
<@rEY_mCbYa1Bs;JlbYVrpmEmVKdU,016;)Ii`X[0?WPI'Xb_b<)*qWRS=G<%to.;Qk;CTGp
2#"&]AqA"^C3'uf*MksHCc/^c&Y%jUOaa=YuW0^LTi?eNJK;Lkjs588H+5j0-j3KM+NH]Ao<$h
^5J<=:\RXsf-Tq1P0W7ic>":Y6kh(\8j*qn15X5tV0&=pI<*W-V`A_lXl/mXEY@C"R,&:Nii
Cu7?X?FnsbAas:o$="?2uXmi?2/;()\(^"+u@-aFQg#Zpcf?KOlA6u(ot?KBZ^,<c&+gABuS
OF:TNjipL>LfN35W+"UO'&'5dpd_;5Fu_@D'nQMU_Ae0Sr.d^VsEq19,,goYJ89`0cS@44C"
qs*QK4ei1VAC)l;Ht0X*6'l?&`S/r6QHeakkdWC#E90)==/ZB%R`KPj^Y[KORE"8]A]A>"8tT%
Ud5'`W'*UIm=AJ6^b'XJ;f9<.L48-`=V_WFnE+QLW<!`'JM"4-f.@)P9erbrjHP--Xu"*+>q
[KG+-$X=]AFIInOU6'-OMkrZ?X6X"QGSQ#lKb=M0;$:k^rY/H2$j87-Ip'\Va=r@s3\C=D^X!
i2Z$le&NmQM6nS7&KHAo'$@!WjkGZ^#Y^#p-;,Rpa2V2X63`YSFR<H9;LV/_,Wj'X`?WhfB[
AsrRXL+F<>/&!6I6pKYo<&l!%3Pb0D#eq'W&\1LS.%$4roLnPKpuD;X$J"g[="Nihra!YVG@
ihbN-ZEi5/lZ;`l\W&bBD0=/ZSprZ+auO.2n&SH=XQNn?jK2!7eo-3aZ_St.'K)-<V7"hI4&
M#4==b>E+"253g&>R[3omh;;Kg5PT(LfiAg,rAFfA/?X43WQ>-t3TB7#<efD<l6mJCBq@8Li
ji9^%2Jt7ej&<t)@?l'X##bqAK$\'kM`jNW$iZEEkFrKVf-V,hOX-:V*"Lbe-nU,b"pM*S\D
cCDZQ<pm<+I1/6+Zmij-,k9"/A36U'\a0P5Sca0Pdi#tlVh+Lm.;l71khDF2.P9qDPL0MJ]AC
QbG&i?8n:Ae6N/GoUoLq,+SH!R;McMSW4XAbLgajZ=eTg>E@45mrH*EFD65$^H;X;%+@ees\
1J3^!3+7j;UqP=8C==[P'M.j"TX?6)pk;g0#btXaIt-Wc7E&6?`e=\[[?qXE'8)?Wmp1)X(N
dHa>b]A^I#Fr7t7&Xij%eI`u-6GC:h6q0ug:JlWr2jTk+3jO?#X,H`]A`/)P+7br)/*CCXZe%r
(OQTjaGfEJcK4o#_fk[k%\t6\^_`G=<c$f_>^%@_C)!W"(/*Jbj`.OXS`WNh6#X(qWF)1#%Q
31("%2":[NXli`Rg[$Tmp(BSae%.0!GO;r>0>,FHZ!h<JO^`GjWpj,dSDrSG)KuJ#3L%#K^:
gASNLkS;PP<QqF,bL8#Okd3iX90gJ3f(I[h7gF&hX^=?\6t@_b.Zf'5i[a$nf5HZc)$ib'eS
ciPG"43i%.61=\Jd%PkS4LGuk"Zu+>?T8co-mticbk;lsN:`=3pG&7XqfiaP>=\AHhlXuR,^
a!(,Q.>]AO*BK,Pa#&nGN9D1Oa^37*DjkKo<@"mXIGraqnG]A^/fEOqS6S8?cJ;u2*I8iPFEHL
RR"BJt0LNMu#G<.V.#(^lO&t0@k,,bJTf$8!s7PRD1oOp*nF_UPmW^[eda$7d8#O:ORh9e3`
HKFE`:4Xj5(-?YMC#(=CqP2:gB+HiEsD9tU]AkhZ_EZFoRf.a3\csqB[ARnfVCD>C>hT8X*9B
oJWT*Y-7G3G?iWIU<-;C'gYW(tnR0'Xd\$6o=;8uV7k1_ULSaNrg8GkTba(P=.#Ib6s"j&XO
-@6a+:`/ie*A`(iBRr,d2l`71LZ^[?5J-f5!OK848L!t!@n=U`O'.H4?7!^&_;2R7d&V0B5)
6IOHFj/pSVa_FL_-(_aKQrk"]ASX,eS=1lpuijN@U(/"!d;c(RGWEDdT'T<>3cdV<A'tD.ES9
Ee5Y'<U:Vr6(6jh2gc'dP5MWNj8//^]A,X9Lppi@q@@\:aV-@7Ti/"iH-d*0("$'%&e6&er;J
R"<s5oN3"[_tJ>WS6JuS57.trYEY9NIP@b*WhA5X@#d(5G?)KW&P,l"X/F)[pOp)(<QT)ci6
)h^hV3ifY)=Eg3hkV]Ai2/:V28hsEW(.]A-M/]A4Op'bCFKcFO=gUJld!e,14"r7q]AFMY<&j`Y/
3*q(pkp;grG:G?r^Q]A^JU2nngf$9^4J5]A5mCp4bfLqT#SXRuIp.X!\`rRee`<"MP,+pQ^p*[
+EiM!gj&,5E_m@Td;RnK:Mt6/um!<"k@\)J\'d2mD>q$8XQ(_V*[kkI]A+oSKO6PXX/Oa1Qn7
L6kVh,rZGJ'n14@\)WGbZBuE_oXoC0n[6kS7a)u&mM^20i*e5G(5[dJEAMe!63P"<<GRVH!=
2(*?.^V+q:D8beEDL5KOM6@1+pVQO.>;,JD*Tmu[s(ls7I6+(Cf-jUb;Mb=gg?'gakD'cWLm
eT%cU`qEq#0+1ZNHp?lG2L.O"5LHS:VF.!q\;;dJtb<4mYg_fq]AAOi;r.IV7-f2I\ZpJi_f)
qMq3\EZ/N[1K-WBChl'V;fkls;3a>>'#X5@j8^K<j-"EFC57IgN+[d1#qds:r]A&0D0N0O)0i
nbCLK?H!4?pe/%5,go1UD<;'ZiA,hr==i8mmj8q^^s=7]AED.KI*+_G153Fj4@p;Ho7R!12EC
L&3)(\0?63G-8sB:Q&+E!VA>>TM;pgl/kq]AVjYu]Al5!=5!.;d&5i)BuM1UD<;.Bq$'RIk7Od
!@kY+S3uqcN[?KC++Wd;Yu/N_j*TBbVbb8m7T@e/890]AW%!a'\cRk\'kpe^RQ%2d1ao4Wof#
gFE\EbD;lg8+hInr6Y`8-`RFrWf[#Qo1]A<$\jM6*aGn7`G:OV"^VSSlgK?.JaDebt_=hk`]A@
<Y`#>Va[_4VPNoH2-9%oTb2!013K#9?\!h@Hd#<YX\U6W_TJk"6u+j[?ZYI-kR*VRU<fUo,A
GYM2`e-sC]A5?OH"uOOW9SV&YuGJJ3:54c`[=]AY2G+c&&kTBdS<a?pFnMBPX)`Ja92CtZ@i?(
-UZOMqZ$bHgfg*i8#S@/U4Mm9=1U(uC<)RfLQ,h1=,-+J90_J"SF_7VC>3Ntg%e$;t%c*Zug
^\:-&WjA:D#=]AsEoCL06n:-F7_L<;KK_=>Oj\>R`D1:\J/%<*,pBL*#+OYZb*sUNp//t+'E8
?#St!ob6C&c(qFk@82'@MJo*!;Bo[c_N=^VaIk^rSaKuL#u!R`NeU2KgV3!_D%]ArQ;j3VuTN
ep`VGl&r>.X*/0FW(Y'M^,)S!dr$OSGHWLX/!0L!O"-#^[GtQ.e@kP/:d,6Mn`\=FJ/?4PR<
Zl$Z_J&lZG'PH3ST$3ffVN:kn+K>B<Ds`\lOnoc'B\!f)Z3+]A8$*f-ijrL>o,%PVr1+&k\6q
b(NjD8SYB`-C6!r9Pl)(LQB]AU./_&m)T,pp!o>[`hL4]A@s<l\HEru8.gJt"MO<MK)SVOL>Id
WU_/)Kc9M^p[X1Eu-o)K&1JH`=A7pkn&4+J1+Xe:;Si+UQUrrE<%GFr?H@[P'^QHA+T7O5[U
+?Vqf?R7IBGLe$r^Ki#&;nIjS_n?+(7%:@C&T`e(D1.d,_-&pPVm^s2L$aK%T,$.3]A)f!c&f
WJ4%Wl7+77mCtMp2c!@m%5NW?&-]AprGSFL`P)VBj#6@:-m=&%DH(/@Pl@Pi<l93OLNh=Fj%e
Kgud3(/2!2=?G'hbRi3+tiBW0,;bMEI//ZRUYi9?%nLYqp/]ANE0f_IW:00m3cXs)oTVa(BLT
qW-e7qZNX94Tqj,)CTq]A;P@PEXCh>(o_Qr69oDg,ZPgm8OF7TATAK:$Jm"!gQE&tlrFXbSlk
5_';;t7Cqq0_&@2TOk-YA8sPb9tGr_k?)TDXOe?m0.ZX?;ac<@g7tUM@36f\0NP!]Achs0"+f
b7"r&ju<ZQM72$==>Sa?T^5L!b6Th,Lk=a`ALFSPQ.-V^#/WlFTtC"pC<4l<0WNY37Z9b,DI
K=UA2NbO/.\3a^NFnjk8nQC?3RQn2opk-?2OonX0b7njsbE`Lh4@trE'?iRJ+i%]A`hN?[*c=
]A[/T+e]AoV<QiK:uAU`L-'Dee#7dk'lP*c2.%Mm(-29<:qFjlRA,@Ra&?c:&]AGj+U^-RbNf8'
jR<A<f-(:]A"jZq]AQ\Y7`E#bWiSMOF6>D'GVjluX[jk^/tdcEVnH^fEs)AcfmQIR<UUp\6ia\
Cnf.kC>=g<pM_'.c_'@OHY?a((=<>6%1Tra,R@COo-D<CU,k&@(j^,%EJ[,90b%_6u0]A?4M.
;FqON3<o^h6`5_T9cUrWX^R;Le'goL6KVNuHJ^]AH!dg%&<Y,cCngQ\q,5ZepAL!ktX58&L5!
!F4jO%["kn+0>/j+B[HRTJ4]ABO#)%g*Cil(=]A%.hHaZR'^dT]A-.?S&n0BXsNL;]AHIi=g-\8A
o<n!OsM61j?;Bri&1j%P7LmQU`=tY,.fP-jXVZJ'3B^fQHl=!hNMZ*(2BOf&]AO,6j<@qC8nQ
]AF=#/Qc/B>Mn%'(mK!2V1E1l[+-f=r`Mh#+Sce9$-]As^)745SYRn_0DMQd<Z81A^^J#:@ED`
[+1ES*!_IWmS'e>Bj?UQ9Mo!"DV,Sq+M*fJD&^X\td/sB;LmoH<`pZE?[THSb?,Vd*,6$9H!
WqTd6`0d:Cl1$`U2Ip^g@Zk%t-g@IK%VEpm'0m65=t2n=IH^":2+_u9/7;u;C)F4BmAD$_%7
bMJL#2ECU[J9UH?EnZZcV7r/$TF4OrAr)lY.Tndq9-\+II%U@l@AM`Zi]A@.e9SmZuiV`trA=
4(E*gT]A65,Hc^+O3d%,/amdH*;Ff1%B^,B\dX^l'pp%]A^6V;bcJBF<TM7Cit]AN6X.8>C6j,]A
i!OQE:]AW]A9\&FX_AD;@7[`Sgr*.Bo%j,3ju8haW4_g,i7Dc^Wn8[S[e?S^Lr9qL0l(Q#M!pa
9pYgAV!:Vllst8fRj18XXOED>[sC8[ToQjiFW*Egj@SpL,M^a^VGWUkbB7e9PL:GM+N(6;_j
m/!4gE#/iOjifnI"-@hq05a>hj2pX]A3f_32168Jp!pg\V%`Zg<_E_%L8ico/O9BP>NU6FF`0
90ikVDeSuKFYZCcfjZC#;CN,*op$[?egO;l?86UiJ8iBh#kd$\^Nfhc[k=T-mn=l<2@+%m-e
"<_T?[K1D]AbndM-QXr[o3XVGr?B/SLFT[STbMfaebm<28p\AFPf/Xf)ju`Kn>*SDguLCq6Td
m))%Uco@E=o!r~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="1199" height="36"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="Title"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList/>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G-;;g5[b+_n#@_X>""Gq-bAcE95r$bP^S!g9@-FkKAk[-gJ#K\3k8D)?O\01-@ikfsZBqe
BkM2\hUrmBXAW6;RtC5S@A3O1*2(&0V;l<0Tcn"NV+pchhU13h84Q4^aSlGsc3=,N5-h4nkJ
mq=-K.Hh76Ff2BMQX^$T'8GLBCId(tX=X6IuYWk7V"TRPNf]A$iQH#r)j0>6kEULseC[r]Al7"
IWQo46f%Wm;`:&DsEOBoA:0ei)8\-+8kbKqbJ]Au3%qgLGjjh7MZo`#3jMglX,93hf8I:m??9
aELQ,\IWuAVdlZfQdM&n61T&*GogH+ohnQT"#:'3uUa=o^0I"V&+a`;.mQ+]A_+8%Z4>rVh"*
rm%P3;@2%G(<a=#f*D?MbMU%qd&G6P6e597TDqDc"Q*7j2^-Rk8tK9Z,fgK8]A".0Xln'`NS)
>'YM3N>*c4@=R9k3EtV>?6W1;%gWmH3q.'C4?(?a6a,atIUE"i>S>Mr22ACJ1L;k]AsngPi6=
ug1q]AhY-oB@G-(fF%a/3%'B%%KBL1#J`'M:1B\5M<hu$%K;g4bJ8X9=I-Qa!3<dNVf$.<:)@
r6<>>6!UnN5>8?IoT($I>;\,73$lLY@Q0HaPf#:3u*b2[G0DBam)62M4A&gni##ar#\X!9qV
$6o?s41./P[RYNrrF1V!HSr(>Y?"o+@m\/6#,5ES.u^;F-8Ik$H:C`LoIRSA:CY0_J+a/Dc!
]AV$+Ce=ibe]A<+_Z!FC)Z3"YC_p)2O;OGM-Y_Fe)CAdU.fW`?r67k&IY%T8ZfOYb3Sjcnd6T&
5PhaWL1\&2n?doWXj(*bGkr)>I8dI`Fe(O:qNfmU,=LqES6W=l[?%c)+BDrQk;3e$MnQTodD
bLT8o7Nc.6@lR6Nsnqtg`gJkp.fbK_Ts2.R/ao5Q()R6c2nBom\`3Vq`WcoG"F:S-_VGXkQW
crN/&*&FfZl`i6d!E@eWc`"E=r"!.U%L#'(ners`nIXqX2QFGTCf<S=8`+^JDLdmDQ^V=)tr
*$EL*2,Z*"iIcE%\K%f?#3HE#,!`pO.5J)"QJ.4$kipZq_!i;8EaJ(5XY^PqWaqi1k\JbSFW
Pe<T;8p@+^mJ#AiYsW+bapR'G$6l(aN)4g]AQg4(Zm&H>7f5s)]A*XYO8@pH(PC6^.M(QQYFEN
J$2N90]ASTWt!=<s!UB0s9(i"Wi;TjhG)^__,Wg9)RgA[@UCq;aPQ%ItCI+Au)jNF7ioeR_>(
mL)kMOo&Zn>ep?3Q,As-:P<8bQCd<1Q9G<5lc21beT2@E(0Xhj(R7<YA%5`t?G=N3?%Yq<E6
Qkh*M25N@Ut$lkgW]ARMfjN(N5s3?,Q!]AU^ra@mDb*:#"qY-.TdjUqr\=&Sn%7`M38i\k*G[o
D;,=t,=SP/&gf0)c7[83L0<f<s7O=^5X^UWRPksI&aiBKW%qJ72jD<nd%r#^o2+gL&%@?tgE
B<Z>ens:b1iO..uC$I1/*k!j'dmU/+;^oe)7RYCPG7cB):F+2S>#32XbMIna(+itnjNH<#AW
)F/)?mhB\Y82]Ar!hKcV.j,$qP['t1H#im`:ksA*-9igR_&0+e1ta$*>EdceKr=R=_ZO]AO'R*
Q+6!",p<K`$@quOh_VLg94ZLGqTa6oX=ed*"$Dn1W'CPLkZMA#n,3";P?NC:p=B6,9;op4Z+
*;Jgb0kSO%j#L&[hEY8q_(H9[pf+M(c8r'9[hCprI@R$fSIJ^?0N8i,Y]AOW%?V'DA9a,JHZ"
l[)ctW<IroGjQ'm^T)N'-/I6)YOEl/haR+\!be9>u=NlW\J'd58''H7e7_Wjj(d)'g/=<HOA
LEr,J_T5=rRR!Z@4AZ\t"7f49i^#n0o)%=QO#k\.-&/#c#m$"%!"K`%+emQSZ?dh&Zj-*1W4
SU5?PFDp6B-EH_:VhHD<ET56t55)h:>Zg4,eEIM,r:MD10EN\<:]AY-]AGMPVkpB&Y&l1M,c>?
<I7;'3QFBC#AP*aMOH2l]Ab\9%n91C\k!#[]A>Dg]A*j'k&=I#7B$Ujl,kAgp4IZ4/>jM0ZfL8T
W-fRV5=S^QaVRG?"m[a**UN3,=fZ5HH@/`[+_cR*\F6F#kN1ea3j?[FG/b.bap\V?G!"V4s:
*o>fH"pIChS9^Uc/mW]An+6Ia```*U2^d0NIHl#]AeH71SR<@Fb#'Xg:P6%*\j,aE8nFa,KbP<
-)HfG^\n'n(J]A4`mG/u,M?qD[*2U4N-isq*Deti9+%+7$o))73GGoXVLsBPG(M(X>4FJ4YK*
OZpQ?/O+3S(7_KP5utFm&0TT3;t5'[aB^:WH'E@j..Er;OPQ-gXI;dB!2'$eUppp21$iXa_u
@K(,500n3;Rs-^FC//nR&bV^7?p6Td!2b)=LACjsrf;)et7H$/A[>`R(.Qq9anbgfm=W2Wa-
coid-'GZ82<8a4DNHEOKZc!25>i5+ai%%\+U2(9Y]AZ28:tNt?cu^F/h]A;3ag1UPq"O^TZqg^
,0\2!H!Ksa/i;%G9b"4>VD[KVncY=4^KH">.RF]AITE8VP=D#R8E@-GYf,qi7a`@l/osTCRmh
*d_UoDs?&O$OS*j1bi(._Y/nBdNO?j9j6gFCc9;Cmg&pE9:P*nAB;QMikTU>]AI^24CkDL>6J
qLCl0g73N+ZcIiAd"Ti:fi;%+c*F!C1udg7+(IGPM>V*;cF9hkLo[R_,p3![uRbCo&nnaHdg
_25=^"qADs\im=VBYYB51b03tI%Y67"EB4pK7u`rgn)^KW/Y-S8CApNjh\M['Zh43Z#c=UpL
KXP%j2Xn[`SeG^Aeq4:7=A#g"(pmZTl>c\HPm)R>d"*G%YJ\=H=mV,&Pql`/T8@@*-_:F74-
@U>&`gQ6TjNJOSArLA77%u;4qY.3:thT3N/hiX<=?aR5E8`A]Ab9/6YVK=WsC'_`"DJ_fcU[4
2.13g+ud*+aPE>2,r>_`3Y7t/f--QcV'D_*O=\Jc[QJTC/q9)!]AY!rCN\X__&"?qp\2J?N5_
0[k![CtRHbV"D8GJjq^2!qp)WZf3S5b(D6<l8iEc?n\F'F?dG>)sn%q-u-r5B]AHY/)]A1#2tr
&mTX5SVd,n;:I(2OYg:?8==;/p9,,.b]ABco4R'RqQhHhq3ii>1d^^r%'G2Tq!X*L=j/>-sB;
96^=AiQdCLO\3*UA$Y#i.M(Y.0?h<30X?+Ce,"`R%a3sNZ7IA"0u,6S!0ZXpXsd*CiBSW7eD
</o"o)$$-%!<)l!u1\1[V6TKW;L<dT1u\a"Bnc_3UjSW4s>rj/<NU2^JN($<$n'r*Y]A!_J>q
a_%'_'0"#L$Gn/C#^]AB<i.BJUCG6*em&M>r=d4!,?lu0Q3<G_>$IonIc]A8K6VQgFuob(]A>%<
@\jBQ7Olchr"HQ;+>kK482MF!(Q_dn![6\qOr_>>M.m%dl//!=r)4iFJSOoD_ZYg<;8_UF6L
<rer&QXU=T7[ZhC,SeXpc1sRe-6IZGKjq?/&5n0prWM`*RVEJRBR_q<_Z7%S*2qTcSf.HH)>
8XEbEi_%D7C:JG!uuV7<;P[)_7/"J8,&`Ls.ZKCZFD:B8g*k`i:Lplj)0=USG8HmXo=XT;-q
Xb0g2,4*-T9faUgA:+Rlhn_H]A$YRW_4B6DX+4dg]AoHMOqe>r<kd-fhSt&*uE=`jk(&/6^RY=
NVU'=c3p4*@"Ypg(Uc+7O)tK;+e>>oEbB?K8ncnh,C\-d@lY3ko#N"3b<&Vd@j[#<5:Rc^oP
dR@;iRZ7+W:E/!2WEcE<d:,K!Ti2A!0l:#T0e^cG_\_;U;X_Q26`7:d"9gm`Bfp(s&+A4KkD
5H2^R<&b.[j;K0:ccqn3"O\FcU=r:87+7Ead+Cso)jT)#NTMe5!:<W_"%J:)KH^5XuGk1X'1
Cp'T:BXAj^g:]AaP)_-[Ya(HXYsH<j8DG=8=fS^A$2DoVD:,k-kj&NGFDa+r\tQ&.4`$6oW<P
'!AmVJ1eb@95%3JN)DU0H+gD'QR7._D&Zf8BGC4QFL)$R%'?ig!=31n=JT9X6_GreiaV^N\!
REe"'=rcH5T)'s*$=-+AfKR@/&0mY$\-1_9kK!jYC`&&]A_4jjdU=AR^iH_#47WLot3<'mCE;
djCr7($6'+09s<U*Gc6YY4gDnfIAa2"jhj3'VrMg5M&&Z?_+UOjL08;F?mMe#E2"e6sk_Jp0
-FKWFHJ?FOoC%G\d8@YE\gh'kEY*K&+FM=m'>3$jp@tpN1h*'?W[&q+1?FcoOJjr-Lr#fbMH
cHc(UY.!U>Hb[O.4O0Bqno:s\SlZ^q'#jOPOc4=:#XL_[g'pYP:T5R_Cet6@!=,p3;7/eBb*
'M=E5/i5)HZ"(Kl@q`1b,"0Z5crqL>EapX)eu'FYr?2IOi)p/0n^.&,N)r6%.PlENs#TTF/)
a=W$>5'#nD^J:K#JTOiBZ!%$i=/V%;>"uYpr&F;7--54O+ub[chQ=2/mP@1D59]AV`;0'E*:f
Z'U;C5bTpPH$[%?bLCLhD[nXc+Y)dc8:I/&m:Y1$"1miF#$/_Zq?jrtO-O*%1X)#+i<S/ca3
.TSj%n5NV//iBsMCFFa(P0"DnVoA!_gVT>r**'Ii.2aBU8TmjB!hR20Uk;`eI#bGs5L_CAM=
%Gc#&gBpchLtZ"'+-UI(C\a:QuHakKVN9?ah%oOK$;7O]A15*BUO^bsXuK4VE@or6JN?:UJ]AO
:.:H;"08r]AjUEY7lPo4dYt0u">Id)9qPl`*YI?mgW9^Vi&%;U=WND3n@4OI5g6&mcu'cQM;[
"@Y;pHBm^n`^=k7nOVZ3OYHM]AD`3Va^<OR)/ob"_D7^"Eo&fi5W5ka:NHkAj&H\/8SnI21k'
;3i?,uI#_'?:i9(=)\R>nc0-0I6D!25=AHB&a*6P%^]A*u5uJN6nLH[Q;W>ke_M;E,KX0DKkp
pN//1&X?5U5>mkVA4#h7kRF!0RGB1m_f)N%f<JC6_i)pT'#5bD:W77JE)bNFPm:A*npmXG28
BPV5705A<.IpFf6O%fVgE0Q#eqL":)qdBAh;6<$=kfX0'5:bM\"E6/78GMm<pH_/@_f+\l-$
j'p9@L6b!Ea&3=$g@jj:+E7#Uq@(abE@TQ^m`A<T=g<&<n>>&CIr>[1,1H>g%8nGf[ue7/d]A
Qa,H6X_p.[i3/KV]A_57rMgO=X?N~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="0" width="1439" height="44"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="Pie_chart"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="chart0" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ChartEditor">
<WidgetName name="Pie_chart"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="Default" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-39322"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[="Confirmed TOP 10 Countries"]]></Attributes>
</O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Microsoft YaHei" style="0" size="112" foreground="-1"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.column.VanChartColumnPlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="4" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
<Attr class="com.fr.chart.base.AttrBorder">
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrTrendLine">
<TrendLine>
<Attr trendLineName="" trendLineType="exponential" prePeriod="0" afterPeriod="0"/>
<LineStyleInfo>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
<AttrColor>
<Attr/>
</AttrColor>
<AttrLineStyle>
<newAttr lineStyle="0"/>
</AttrLineStyle>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
</LineStyleInfo>
</TrendLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="true"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="6" isCustom="true"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Microsoft YaHei UI" style="0" size="80" foreground="-1"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#,##0]]></Format>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="3" visible="false"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0" isHighlight="true"/>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="1"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="true"/>
<ColorList>
<OColor colvalue="-3407872"/>
<OColor colvalue="-11184811"/>
<OColor colvalue="-4363512"/>
<OColor colvalue="-16750485"/>
<OColor colvalue="-3658447"/>
<OColor colvalue="-10331231"/>
<OColor colvalue="-7763575"/>
<OColor colvalue="-6514688"/>
<OColor colvalue="-16744620"/>
<OColor colvalue="-6187579"/>
<OColor colvalue="-15714713"/>
<OColor colvalue="-945550"/>
<OColor colvalue="-4092928"/>
<OColor colvalue="-13224394"/>
<OColor colvalue="-12423245"/>
<OColor colvalue="-10043521"/>
<OColor colvalue="-406154"/>
<OColor colvalue="-13031292"/>
<OColor colvalue="-16732559"/>
<OColor colvalue="-7099690"/>
<OColor colvalue="-11991199"/>
<OColor colvalue="-331445"/>
<OColor colvalue="-6991099"/>
<OColor colvalue="-16686527"/>
<OColor colvalue="-9205567"/>
<OColor colvalue="-7397856"/>
<OColor colvalue="-406154"/>
<OColor colvalue="-2712831"/>
<OColor colvalue="-4737097"/>
<OColor colvalue="-11460720"/>
<OColor colvalue="-6696775"/>
<OColor colvalue="-3685632"/>
</ColorList>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<VanChartRectanglePlotAttr vanChartPlotType="normal" isDefaultIntervalBackground="true"/>
<XAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartValueAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="false"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor=""/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange maxValue="=max(report2~A3)*1.2"/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="X Axis" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
<VanChartValueAxisAttr isLog="false" valueStyle="false" baseLog="=10"/>
<ds>
<RadarYAxisTableDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<attr/>
</RadarYAxisTableDefinition>
</ds>
</VanChartAxis>
</XAxisList>
<YAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="false"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor=""/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="Y Axis" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
</VanChartAxis>
</YAxisList>
<stackAndAxisCondition>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</stackAndAxisCondition>
<VanChartColumnPlotAttr seriesOverlapPercent="20.0" categoryIntervalPercent="20.0" fixedWidth="false" columnWidth="0" filledWithImage="false" isBar="true"/>
</Plot>
<ChartDefinition>
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[bar_charts]]></Name>
</TableData>
<CategoryName value="country_full_name"/>
<ChartSummaryColumn name="confirmedCount" function="com.fr.data.util.function.NoneFunction" customName="confirmedCount"/>
</MoreNameCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="a39adfe5-8c05-47f5-b1c3-014a7ea95fe2"/>
<tools hidden="true" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
<ChartMobileAttrProvider zoomOut="0" zoomIn="2" allowFullScreen="true" functionalWhenUnactivated="false"/>
<MobileChartCollapsedStyle class="com.fr.form.ui.mobile.MobileChartCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
</MobileChartCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="300" height="370"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<body class="com.fr.form.ui.ChartEditor">
<WidgetName name="Pie_chart"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="Default" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[New Chart Title]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Microsoft YaHei" style="0" size="128" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.PiePlot4VanChart">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="4" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
<Attr class="com.fr.chart.base.AttrBorder">
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1"/>
</AttrBorder>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="4" visible="true"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0" isHighlight="true"/>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="0"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="false"/>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<PieAttr4VanChart roseType="differentArc" startAngle="0.0" endAngle="360.0" innerRadius="0.0" supportRotation="false"/>
<VanChartRadius radiusType="auto" radius="100"/>
</Plot>
</Chart>
<UUID uuid="954fcce9-581a-4747-a1df-60505f6eb02c"/>
<tools hidden="true" sort="true" export="true" fullScreen="true"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
<ChartMobileAttrProvider zoomOut="0" zoomIn="2" allowFullScreen="true" functionalWhenUnactivated="false"/>
<MobileChartCollapsedStyle class="com.fr.form.ui.mobile.MobileChartCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
</MobileChartCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="125" width="360" height="376"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="Trend"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="chart0" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ChartEditor">
<WidgetName name="Trend"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="Default" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-39322"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[="Confirmed and Deaths Trend of " + if(len($country_name) ==0, "the World", $country_name) + " in 2020"]]></Attributes>
</O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Microsoft YaHei" style="0" size="112" foreground="-1"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.line.VanChartLinePlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="4" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="false"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="1" isCustom="true"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Microsoft YaHei UI" style="0" size="80" foreground="-1"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrTrendLine">
<TrendLine>
<Attr trendLineName="" trendLineType="exponential" prePeriod="0" afterPeriod="0"/>
<LineStyleInfo>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
<AttrColor>
<Attr/>
</AttrColor>
<AttrLineStyle>
<newAttr lineStyle="0"/>
</AttrLineStyle>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
</LineStyleInfo>
</TrendLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrLine">
<VanAttrLine>
<Attr lineWidth="2" lineStyle="0" nullValueBreak="true"/>
</VanAttrLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" markerType="RoundFilledMarker" radius="1.0" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="6"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="1" visible="true"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-1"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0" isHighlight="true"/>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="1"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="true"/>
<ColorList>
<OColor colvalue="-3407872"/>
<OColor colvalue="-26368"/>
<OColor colvalue="-6710887"/>
<OColor colvalue="-16750485"/>
<OColor colvalue="-3658447"/>
<OColor colvalue="-10331231"/>
<OColor colvalue="-7763575"/>
<OColor colvalue="-6514688"/>
<OColor colvalue="-16744620"/>
<OColor colvalue="-6187579"/>
<OColor colvalue="-15714713"/>
<OColor colvalue="-945550"/>
<OColor colvalue="-4092928"/>
<OColor colvalue="-13224394"/>
<OColor colvalue="-12423245"/>
<OColor colvalue="-10043521"/>
<OColor colvalue="-406154"/>
<OColor colvalue="-13031292"/>
<OColor colvalue="-16732559"/>
<OColor colvalue="-7099690"/>
<OColor colvalue="-11991199"/>
<OColor colvalue="-331445"/>
<OColor colvalue="-6991099"/>
<OColor colvalue="-16686527"/>
<OColor colvalue="-9205567"/>
<OColor colvalue="-7397856"/>
<OColor colvalue="-406154"/>
<OColor colvalue="-2712831"/>
<OColor colvalue="-4737097"/>
<OColor colvalue="-11460720"/>
<OColor colvalue="-6696775"/>
<OColor colvalue="-3685632"/>
</ColorList>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<VanChartRectanglePlotAttr vanChartPlotType="normal" isDefaultIntervalBackground="true"/>
<XAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="1" MainGridStyle="1"/>
<newLineColor lineColor="-5197648"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr rotation="-30" alignText="0">
<FRFont name="Verdana" style="0" size="64" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X Axis" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
</VanChartAxis>
</XAxisList>
<YAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartValueAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="false"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange minValue="=0"/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y Axis" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
<VanChartValueAxisAttr isLog="false" valueStyle="false" baseLog="=10"/>
<ds>
<RadarYAxisTableDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<attr/>
</RadarYAxisTableDefinition>
</ds>
</VanChartAxis>
</YAxisList>
<stackAndAxisCondition>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</stackAndAxisCondition>
</Plot>
<ChartDefinition>
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[trend@country_name]]></Name>
</TableData>
<CategoryName value="data_date"/>
<ChartSummaryColumn name="currentConfirmedCount" function="com.fr.data.util.function.NoneFunction" customName="currentConfirmedCount"/>
<ChartSummaryColumn name="confirmedCount" function="com.fr.data.util.function.NoneFunction" customName="confirmedCount"/>
<ChartSummaryColumn name="deadCount" function="com.fr.data.util.function.NoneFunction" customName="deadCount"/>
<ChartSummaryColumn name="curedCount" function="com.fr.data.util.function.NoneFunction" customName="curedCount"/>
</MoreNameCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="81f18975-92fa-4d1e-9652-ce9d4b02c393"/>
<tools hidden="true" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
<ChartMobileAttrProvider zoomOut="0" zoomIn="2" allowFullScreen="true" functionalWhenUnactivated="false"/>
<MobileChartCollapsedStyle class="com.fr.form.ui.mobile.MobileChartCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
</MobileChartCollapsedStyle>
</InnerWidget>
<BoundsAttr x="300" y="0" width="615" height="123"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<body class="com.fr.form.ui.ChartEditor">
<WidgetName name="Trend"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="Default" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[New Chart Title]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Microsoft YaHei" style="0" size="128" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.line.VanChartLinePlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="4" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" markerType="NullMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrLine">
<VanAttrLine>
<Attr lineWidth="2" lineStyle="0" nullValueBreak="true"/>
</VanAttrLine>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="4" visible="true"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0" isHighlight="true"/>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="0"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="false"/>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<VanChartRectanglePlotAttr vanChartPlotType="normal" isDefaultIntervalBackground="true"/>
<XAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="1" MainGridStyle="1"/>
<newLineColor lineColor="-5197648"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X Axis" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
</VanChartAxis>
</XAxisList>
<YAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartValueAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0">
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor mainGridColor="-3881788" lineColor="-5197648"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y Axis" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
<VanChartValueAxisAttr isLog="false" valueStyle="false" baseLog="=10"/>
<ds>
<RadarYAxisTableDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<attr/>
</RadarYAxisTableDefinition>
</ds>
</VanChartAxis>
</YAxisList>
<stackAndAxisCondition>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</stackAndAxisCondition>
</Plot>
</Chart>
<UUID uuid="7d885c8b-3807-4149-b1f7-e94e7440f71a"/>
<tools hidden="true" sort="true" export="true" fullScreen="true"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
<ChartMobileAttrProvider zoomOut="0" zoomIn="2" allowFullScreen="true" functionalWhenUnactivated="false"/>
<MobileChartCollapsedStyle class="com.fr.form.ui.mobile.MobileChartCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
</MobileChartCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="360" y="501" width="739" height="216"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.cardlayout.WCardMainBorderLayout">
<WidgetName name="tablayout0"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="tablayout0" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="1" color="-723724" borderRadius="0" type="1" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
<Background name="ColorBackground" color="-855310"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<ShowBookmarks showBookmarks="true"/>
<NorthAttr size="30"/>
<North class="com.fr.form.ui.container.cardlayout.WCardTitleLayout">
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<ShowBookmarks showBookmarks="true"/>
<EastAttr size="25"/>
<East class="com.fr.form.ui.CardAddButton">
<WidgetName name="Add"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<AddTagAttr layoutName="cardlayout0"/>
</East>
<Center class="com.fr.form.ui.container.cardlayout.WCardTagLayout">
<WidgetName name="tabpane0"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="tabpane0" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="1" compInterval="0"/>
<Widget class="com.fr.form.ui.CardSwitchButton">
<WidgetName name="0c82f8d9-9495-4358-8aa9-2e708a4c8b0d"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="0c82f8d9-9495-4358-8aa9-2e708a4c8b0d" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[World]]></Text>
<initial>
<Background name="ColorBackground" color="-9782532"/>
</initial>
<over>
<Background name="ColorBackground" color="-1"/>
</over>
<click>
<Background name="ColorBackground" color="-39322"/>
</click>
<FRFont name="SimSun" style="0" size="72"/>
<isCustomType isCustomType="true"/>
<SwitchTagAttr layoutName="cardlayout0"/>
</Widget>
<Widget class="com.fr.form.ui.CardSwitchButton">
<WidgetName name="fb2c4d24-bc84-43e3-b5e6-446de17ee88d"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[World now]]></Text>
<initial>
<Background name="ColorBackground" color="-9782532"/>
</initial>
<FRFont name="SimSun" style="0" size="72"/>
<isCustomType isCustomType="true"/>
<SwitchTagAttr layoutName="cardlayout0" index="1"/>
</Widget>
<Widget class="com.fr.form.ui.CardSwitchButton">
<WidgetName name="b9c4b117-04dd-48fa-9c20-ecb75c1ee389"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[China]]></Text>
<initial>
<Background name="ColorBackground" color="-9782532"/>
</initial>
<over>
<Background name="ColorBackground"/>
</over>
<click>
<Background name="ColorBackground"/>
</click>
<FRFont name="SimSun" style="0" size="72"/>
<isCustomType isCustomType="true"/>
<SwitchTagAttr layoutName="cardlayout0" index="2"/>
</Widget>
<Widget class="com.fr.form.ui.CardSwitchButton">
<WidgetName name="f1fbce42-9ee0-46d3-a950-789921193062"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[China now]]></Text>
<initial>
<Background name="ColorBackground" color="-9782532"/>
</initial>
<FRFont name="SimSun" style="0" size="72"/>
<isCustomType isCustomType="true"/>
<SwitchTagAttr layoutName="cardlayout0" index="3"/>
</Widget>
<Widget class="com.fr.form.ui.CardSwitchButton">
<WidgetName name="510e1472-57fa-47f2-8f2f-4bb015f88255"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[Rose Chart]]></Text>
<initial>
<Background name="ColorBackground" color="-9782532"/>
</initial>
<FRFont name="SimSun" style="0" size="72"/>
<isCustomType isCustomType="true"/>
<SwitchTagAttr layoutName="cardlayout0" index="4"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<DisplayPosition type="0"/>
<FLAttr alignment="0"/>
<ColumnWidth defaultValue="80">
<![CDATA[80,109,80,80,106,80,80,80,80,80,80]]></ColumnWidth>
<FRFont name="Microsoft YaHei" style="1" size="72" foreground="-1"/>
<TextDirection type="0"/>
<TemplateStyle class="com.fr.general.cardtag.CardTemplateStyle"/>
<MobileTemplateStyle class="com.fr.general.cardtag.mobile.DefaultMobileTemplateStyle">
<initialColor color="-13072146"/>
<tabFontConfig selectFontColor="-16777216">
<FRFont name="Times New Roman" style="0" size="72"/>
</tabFontConfig>
<custom custom="false"/>
</MobileTemplateStyle>
</Center>
<CardTitleLayout layoutName="cardlayout0"/>
</North>
<Center class="com.fr.form.ui.container.WCardLayout">
<WidgetName name="cardlayout0"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-1" borderRadius="0" type="1" borderStyle="1"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Microsoft YaHei" style="1" size="72" foreground="-1"/>
<Position pos="0"/>
<Background name="ColorBackground"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.cardlayout.WTabFitLayout">
<WidgetName name="world"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="5"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="world_map"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="chart0" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ChartEditor">
<WidgetName name="world_map"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="Default" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.75"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[New Chart Title]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Microsoft YaHei" style="0" size="128" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="false" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.map.VanChartMapPlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="4" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.chart.base.AttrAlpha">
<AttrAlpha>
<Attr alpha="0.75"/>
</AttrAlpha>
</Attr>
<Attr class="com.fr.plugin.chart.map.attr.AttrMapTooltip">
<AttrMapTooltip>
<areaTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</areaTooltip>
<pointTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</pointTooltip>
<lineTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipStartAndEndNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</lineTooltip>
</AttrMapTooltip>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrMarkerAlpha">
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</Attr>
<Attr class="com.fr.plugin.chart.map.attr.AttrMapLabel">
<AttrMapLabel>
<areaLabel class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="false"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="5" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</areaLabel>
<pointLabel class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="false"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="5" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</pointLabel>
</AttrMapLabel>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrBorderWithAlpha">
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1"/>
</AttrBorder>
<AlphaAttr alpha="1.0"/>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrEffect">
<AttrEffect>
<attr enabled="true" period="3.2"/>
</AttrEffect>
</Attr>
<Attr class="com.fr.plugin.chart.bubble.attr.VanChartAttrBubble">
<VanChartAttrBubble>
<Attr minDiameter="12.0" maxDiameter="60.0" shadow="true" displayNegative="true"/>
</VanChartAttrBubble>
</Attr>
<Attr class="com.fr.plugin.chart.map.line.condition.AttrCurve">
<AttrCurve>
<attr lineWidth="0.5" bending="30.0" alpha="100.0"/>
</AttrCurve>
</Attr>
<Attr class="com.fr.plugin.chart.map.line.condition.AttrLineEffect">
<AttrEffect>
<attr enabled="true" period="30.0"/>
<lineEffectAttr animationType="default"/>
<marker>
<VanAttrMarker>
<Attr isCommon="false" markerType="NullMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="ImageBackground" layout="2"/>
</VanAttrMarker>
</marker>
</AttrEffect>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="false"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="5" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" markerType="RoundFilledMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="3" visible="true"/>
<FRFont name="Microsoft YaHei" style="0" size="48" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0" isHighlight="true"/>
<Attr4VanChartScatter>
<Type rangeLegendType="2"/>
<SectionLegend>
<MapHotAreaColor>
<MC_Attr minValue="100.0" maxValue="200.0" useType="0" areaNumber="6" mainColor="-6750208"/>
<ColorList>
<AreaColor>
<AC_Attr minValue="=200" maxValue="=220" color="-6750208"/>
</AreaColor>
<AreaColor>
<AC_Attr minValue="=180" maxValue="=200" color="-5628900"/>
</AreaColor>
<AreaColor>
<AC_Attr minValue="=160" maxValue="=180" color="-4506050"/>
</AreaColor>
<AreaColor>
<AC_Attr minValue="=140" maxValue="=160" color="-3381658"/>
</AreaColor>
<AreaColor>
<AC_Attr minValue="=120" maxValue="=140" color="-2255981"/>
</AreaColor>
<AreaColor>
<AC_Attr minValue="=100" maxValue="=120" color="-1128762"/>
</AreaColor>
</ColorList>
</MapHotAreaColor>
<LegendLabelFormat>
<IsCommon commonValueFormat="false"/>
<HtmlLabel customText="function(){ return this.from/1000 + &apos;K-&apos; + this.to/1000 + &apos;K&apos; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</LegendLabelFormat>
</SectionLegend>
</Attr4VanChartScatter>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="1"/>
<FillStyleName fillStyleName="classic"/>
<isCustomFillStyle isCustomFillStyle="false"/>
<ColorList>
<OColor colvalue="-16765869"/>
<OColor colvalue="-23280"/>
<OColor colvalue="-15956794"/>
<OColor colvalue="-17050"/>
<OColor colvalue="-570035"/>
<OColor colvalue="-14395996"/>
<OColor colvalue="-12470356"/>
<OColor colvalue="-16765869"/>
<OColor colvalue="-23280"/>
<OColor colvalue="-15956794"/>
<OColor colvalue="-17050"/>
<OColor colvalue="-570035"/>
<OColor colvalue="-14395996"/>
<OColor colvalue="-12470356"/>
<OColor colvalue="-16765869"/>
<OColor colvalue="-23280"/>
<OColor colvalue="-15956794"/>
<OColor colvalue="-17050"/>
<OColor colvalue="-570035"/>
<OColor colvalue="-14395996"/>
<OColor colvalue="-12470356"/>
<OColor colvalue="-16765869"/>
<OColor colvalue="-23280"/>
<OColor colvalue="-15956794"/>
<OColor colvalue="-17050"/>
<OColor colvalue="-570035"/>
<OColor colvalue="-14395996"/>
<OColor colvalue="-12470356"/>
<OColor colvalue="-16765869"/>
<OColor colvalue="-23280"/>
<OColor colvalue="-15956794"/>
<OColor colvalue="-17050"/>
</ColorList>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<VanChartMapPlotAttr mapType="custom" geourl="assets/map/geographic/world.json" zoomlevel="0" mapmarkertype="2" nullvaluecolor="-3355444"/>
<areaHotHyperLink>
<NameJavaScriptGroup>
<NameJavaScript name="Current Form Object1">
<JavaScript class="com.fr.form.main.FormHyperlink">
<JavaScript class="com.fr.form.main.FormHyperlink">
<Parameters>
<Parameter>
<Attributes name="country_name"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=AREA_NAME]]></Attributes>
</O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<realateName realateValue="Trend" animateType="none"/>
<linkType type="0"/>
</JavaScript>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
</areaHotHyperLink>
<lineMapDataProcessor>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
</lineMapDataProcessor>
<GisLayer>
<Attr gislayer="predefined_layer" layerName="Black"/>
</GisLayer>
<ViewCenter auto="true" longitude="0.0" latitude="0.0"/>
<pointConditionCollection>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</pointConditionCollection>
<lineConditionCollection>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</lineConditionCollection>
</Plot>
<ChartDefinition>
<VanMapDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<areaDefinition class="com.fr.plugin.chart.map.data.VanMapMoreNameCDDefinition">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[newest_world_confirmed]]></Name>
</TableData>
<CategoryName value="map_country_name"/>
<ChartSummaryColumn name="confirmedCount" function="com.fr.data.util.function.NoneFunction" customName="confirmedCount"/>
</MoreNameCDDefinition>
<attr longitude="" latitude="" endLongitude="" endLatitude="" useAreaName="true" endAreaName=""/>
</areaDefinition>
<pointDefinition class="com.fr.plugin.chart.map.data.VanMapMoreNameCDDefinition">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[newest_world_confirmed]]></Name>
</TableData>
<CategoryName value="map_country_name"/>
<ChartSummaryColumn name="confirmed" function="com.fr.data.util.function.NoneFunction" customName="Confirmed"/>
</MoreNameCDDefinition>
<attr longitude="" latitude="" endLongitude="" endLatitude="" useAreaName="true" endAreaName=""/>
</pointDefinition>
<lineDefinition class="com.fr.plugin.chart.map.data.VanMapMoreNameCDDefinition">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
</MoreNameCDDefinition>
<attr longitude="" latitude="" endLongitude="" endLatitude="" useAreaName="true" endAreaName=""/>
</lineDefinition>
</VanMapDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="0d599949-092c-428f-a1cb-52d37b69539e"/>
<tools hidden="true" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
<ChartMobileAttrProvider zoomOut="0" zoomIn="2" allowFullScreen="true" functionalWhenUnactivated="false"/>
<MobileChartCollapsedStyle class="com.fr.form.ui.mobile.MobileChartCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
</MobileChartCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="615" height="305"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<body class="com.fr.form.ui.ChartEditor">
<WidgetName name="world_map"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="Default" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.75"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[New Chart Title]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Microsoft YaHei" style="0" size="128" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="false" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.map.VanChartMapPlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="4" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrBorderWithAlpha">
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1"/>
</AttrBorder>
<AlphaAttr alpha="1.0"/>
</Attr>
<Attr class="com.fr.chart.base.AttrAlpha">
<AttrAlpha>
<Attr alpha="0.75"/>
</AttrAlpha>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrEffect">
<AttrEffect>
<attr enabled="false" period="3.2"/>
</AttrEffect>
</Attr>
<Attr class="com.fr.plugin.chart.map.line.condition.AttrCurve">
<AttrCurve>
<attr lineWidth="0.5" bending="30.0" alpha="100.0"/>
</AttrCurve>
</Attr>
<Attr class="com.fr.plugin.chart.map.line.condition.AttrLineEffect">
<AttrEffect>
<attr enabled="true" period="30.0"/>
<lineEffectAttr animationType="default"/>
<marker>
<VanAttrMarker>
<Attr isCommon="true" markerType="NullMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</marker>
</AttrEffect>
</Attr>
<Attr class="com.fr.plugin.chart.map.attr.AttrMapLabel">
<AttrMapLabel>
<areaLabel class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="false"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="5" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</areaLabel>
<pointLabel class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="false"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="5" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</pointLabel>
</AttrMapLabel>
</Attr>
<Attr class="com.fr.plugin.chart.map.attr.AttrMapTooltip">
<AttrMapTooltip>
<areaTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</areaTooltip>
<pointTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</pointTooltip>
<lineTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipStartAndEndNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</lineTooltip>
</AttrMapTooltip>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="4" visible="true"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0" isHighlight="true"/>
<Attr4VanChartScatter>
<Type rangeLegendType="1"/>
<GradualLegend>
<GradualIntervalConfig>
<IntervalConfigAttr subColor="-14374913" divStage="2.0"/>
<ValueRange IsCustomMin="false" IsCustomMax="false"/>
<ColorDistList>
<ColorDist color="-4791553" dist="0.0"/>
<ColorDist color="-9583361" dist="0.5"/>
<ColorDist color="-14374913" dist="1.0"/>
</ColorDistList>
</GradualIntervalConfig>
<LegendLabelFormat>
<IsCommon commonValueFormat="true"/>
</LegendLabelFormat>
</GradualLegend>
</Attr4VanChartScatter>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="0"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="false"/>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<VanChartMapPlotAttr mapType="area" geourl="assets/map/geographic/world.json" zoomlevel="0" mapmarkertype="0" nullvaluecolor="-3355444"/>
<lineMapDataProcessor>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
</lineMapDataProcessor>
<GisLayer>
<Attr gislayer="predefined_layer" layerName="Fresh"/>
</GisLayer>
<ViewCenter auto="true" longitude="0.0" latitude="0.0"/>
<pointConditionCollection>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</pointConditionCollection>
<lineConditionCollection>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</lineConditionCollection>
</Plot>
</Chart>
<UUID uuid="2b1fbe21-bb70-4a8b-8666-61565deadd05"/>
<tools hidden="true" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
<ChartMobileAttrProvider zoomOut="0" zoomIn="2" allowFullScreen="true" functionalWhenUnactivated="false"/>
<MobileChartCollapsedStyle class="com.fr.form.ui.mobile.MobileChartCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
</MobileChartCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="0" width="615" height="305"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="world_map"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="0"/>
<AppRelayout appRelayout="true"/>
<Size width="615" height="305"/>
<ResolutionScalingAttr percent="1.2"/>
<tabFitAttr index="0" tabNameIndex="0">
<initial>
<Background name="ColorBackground" color="-13421773"/>
</initial>
<over>
<Background name="ColorBackground" color="-1"/>
</over>
<click>
<Background name="ColorBackground" color="-39322"/>
</click>
<isCustomStyle isCustomStyle="true"/>
</tabFitAttr>
</Widget>
<Widget class="com.fr.form.ui.container.cardlayout.WTabFitLayout">
<WidgetName name="Tab4"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="world_map_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="chart0" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ChartEditor">
<WidgetName name="world_map_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="Default" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.75"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[New Chart Title]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Microsoft YaHei" style="0" size="128" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="false" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.map.VanChartMapPlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="4" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.chart.base.AttrAlpha">
<AttrAlpha>
<Attr alpha="0.75"/>
</AttrAlpha>
</Attr>
<Attr class="com.fr.plugin.chart.map.attr.AttrMapTooltip">
<AttrMapTooltip>
<areaTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</areaTooltip>
<pointTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</pointTooltip>
<lineTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipStartAndEndNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</lineTooltip>
</AttrMapTooltip>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrMarkerAlpha">
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</Attr>
<Attr class="com.fr.plugin.chart.map.attr.AttrMapLabel">
<AttrMapLabel>
<areaLabel class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="false"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="5" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</areaLabel>
<pointLabel class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="false"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="5" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</pointLabel>
</AttrMapLabel>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrBorderWithAlpha">
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1"/>
</AttrBorder>
<AlphaAttr alpha="1.0"/>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrEffect">
<AttrEffect>
<attr enabled="true" period="3.2"/>
</AttrEffect>
</Attr>
<Attr class="com.fr.plugin.chart.bubble.attr.VanChartAttrBubble">
<VanChartAttrBubble>
<Attr minDiameter="12.0" maxDiameter="60.0" shadow="true" displayNegative="true"/>
</VanChartAttrBubble>
</Attr>
<Attr class="com.fr.plugin.chart.map.line.condition.AttrCurve">
<AttrCurve>
<attr lineWidth="0.5" bending="30.0" alpha="100.0"/>
</AttrCurve>
</Attr>
<Attr class="com.fr.plugin.chart.map.line.condition.AttrLineEffect">
<AttrEffect>
<attr enabled="true" period="30.0"/>
<lineEffectAttr animationType="default"/>
<marker>
<VanAttrMarker>
<Attr isCommon="false" markerType="NullMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="ImageBackground" layout="2"/>
</VanAttrMarker>
</marker>
</AttrEffect>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="false"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="5" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" markerType="RoundFilledMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="3" visible="true"/>
<FRFont name="Microsoft YaHei" style="0" size="48" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0" isHighlight="true"/>
<Attr4VanChartScatter>
<Type rangeLegendType="2"/>
<SectionLegend>
<MapHotAreaColor>
<MC_Attr minValue="100.0" maxValue="200.0" useType="0" areaNumber="6" mainColor="-6750208"/>
<ColorList>
<AreaColor>
<AC_Attr minValue="=200" maxValue="=220" color="-6750208"/>
</AreaColor>
<AreaColor>
<AC_Attr minValue="=180" maxValue="=200" color="-5628900"/>
</AreaColor>
<AreaColor>
<AC_Attr minValue="=160" maxValue="=180" color="-4506050"/>
</AreaColor>
<AreaColor>
<AC_Attr minValue="=140" maxValue="=160" color="-3381658"/>
</AreaColor>
<AreaColor>
<AC_Attr minValue="=120" maxValue="=140" color="-2255981"/>
</AreaColor>
<AreaColor>
<AC_Attr minValue="=100" maxValue="=120" color="-1128762"/>
</AreaColor>
</ColorList>
</MapHotAreaColor>
<LegendLabelFormat>
<IsCommon commonValueFormat="false"/>
<HtmlLabel customText="function(){ return this.from/1000 + &apos;K-&apos; + this.to/1000 + &apos;K&apos; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</LegendLabelFormat>
</SectionLegend>
</Attr4VanChartScatter>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="1"/>
<FillStyleName fillStyleName="classic"/>
<isCustomFillStyle isCustomFillStyle="false"/>
<ColorList>
<OColor colvalue="-16765869"/>
<OColor colvalue="-23280"/>
<OColor colvalue="-15956794"/>
<OColor colvalue="-17050"/>
<OColor colvalue="-570035"/>
<OColor colvalue="-14395996"/>
<OColor colvalue="-12470356"/>
<OColor colvalue="-16765869"/>
<OColor colvalue="-23280"/>
<OColor colvalue="-15956794"/>
<OColor colvalue="-17050"/>
<OColor colvalue="-570035"/>
<OColor colvalue="-14395996"/>
<OColor colvalue="-12470356"/>
<OColor colvalue="-16765869"/>
<OColor colvalue="-23280"/>
<OColor colvalue="-15956794"/>
<OColor colvalue="-17050"/>
<OColor colvalue="-570035"/>
<OColor colvalue="-14395996"/>
<OColor colvalue="-12470356"/>
<OColor colvalue="-16765869"/>
<OColor colvalue="-23280"/>
<OColor colvalue="-15956794"/>
<OColor colvalue="-17050"/>
<OColor colvalue="-570035"/>
<OColor colvalue="-14395996"/>
<OColor colvalue="-12470356"/>
<OColor colvalue="-16765869"/>
<OColor colvalue="-23280"/>
<OColor colvalue="-15956794"/>
<OColor colvalue="-17050"/>
</ColorList>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<VanChartMapPlotAttr mapType="custom" geourl="assets/map/geographic/world.json" zoomlevel="0" mapmarkertype="2" nullvaluecolor="-3355444"/>
<areaHotHyperLink>
<NameJavaScriptGroup>
<NameJavaScript name="Current Form Object1">
<JavaScript class="com.fr.form.main.FormHyperlink">
<JavaScript class="com.fr.form.main.FormHyperlink">
<Parameters>
<Parameter>
<Attributes name="country_name"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=AREA_NAME]]></Attributes>
</O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<realateName realateValue="Trend" animateType="none"/>
<linkType type="0"/>
</JavaScript>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
</areaHotHyperLink>
<lineMapDataProcessor>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
</lineMapDataProcessor>
<GisLayer>
<Attr gislayer="predefined_layer" layerName="Black"/>
</GisLayer>
<ViewCenter auto="true" longitude="0.0" latitude="0.0"/>
<pointConditionCollection>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</pointConditionCollection>
<lineConditionCollection>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</lineConditionCollection>
</Plot>
<ChartDefinition>
<VanMapDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<areaDefinition class="com.fr.plugin.chart.map.data.VanMapMoreNameCDDefinition">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[world_now_map]]></Name>
</TableData>
<CategoryName value="map_country_name"/>
<ChartSummaryColumn name="currentConfirmed" function="com.fr.data.util.function.NoneFunction" customName="currentConfirmed"/>
</MoreNameCDDefinition>
<attr longitude="" latitude="" endLongitude="" endLatitude="" useAreaName="true" endAreaName=""/>
</areaDefinition>
<pointDefinition class="com.fr.plugin.chart.map.data.VanMapMoreNameCDDefinition">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[newest_world_confirmed]]></Name>
</TableData>
<CategoryName value="map_country_name"/>
<ChartSummaryColumn name="confirmed" function="com.fr.data.util.function.NoneFunction" customName="Confirmed"/>
</MoreNameCDDefinition>
<attr longitude="" latitude="" endLongitude="" endLatitude="" useAreaName="true" endAreaName=""/>
</pointDefinition>
<lineDefinition class="com.fr.plugin.chart.map.data.VanMapMoreNameCDDefinition">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
</MoreNameCDDefinition>
<attr longitude="" latitude="" endLongitude="" endLatitude="" useAreaName="true" endAreaName=""/>
</lineDefinition>
</VanMapDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="5bbc03c1-2b78-4351-828a-545762f2163e"/>
<tools hidden="true" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
<ChartMobileAttrProvider zoomOut="0" zoomIn="2" allowFullScreen="true" functionalWhenUnactivated="false"/>
<MobileChartCollapsedStyle class="com.fr.form.ui.mobile.MobileChartCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
</MobileChartCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="615" height="305"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<body class="com.fr.form.ui.ChartEditor">
<WidgetName name="world_map"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="Default" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.75"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[New Chart Title]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Microsoft YaHei" style="0" size="128" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="false" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.map.VanChartMapPlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="4" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrBorderWithAlpha">
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1"/>
</AttrBorder>
<AlphaAttr alpha="1.0"/>
</Attr>
<Attr class="com.fr.chart.base.AttrAlpha">
<AttrAlpha>
<Attr alpha="0.75"/>
</AttrAlpha>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrEffect">
<AttrEffect>
<attr enabled="false" period="3.2"/>
</AttrEffect>
</Attr>
<Attr class="com.fr.plugin.chart.map.line.condition.AttrCurve">
<AttrCurve>
<attr lineWidth="0.5" bending="30.0" alpha="100.0"/>
</AttrCurve>
</Attr>
<Attr class="com.fr.plugin.chart.map.line.condition.AttrLineEffect">
<AttrEffect>
<attr enabled="true" period="30.0"/>
<lineEffectAttr animationType="default"/>
<marker>
<VanAttrMarker>
<Attr isCommon="true" markerType="NullMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</marker>
</AttrEffect>
</Attr>
<Attr class="com.fr.plugin.chart.map.attr.AttrMapLabel">
<AttrMapLabel>
<areaLabel class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="false"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="5" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</areaLabel>
<pointLabel class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="false"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="5" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</pointLabel>
</AttrMapLabel>
</Attr>
<Attr class="com.fr.plugin.chart.map.attr.AttrMapTooltip">
<AttrMapTooltip>
<areaTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</areaTooltip>
<pointTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</pointTooltip>
<lineTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipStartAndEndNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</lineTooltip>
</AttrMapTooltip>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="4" visible="true"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0" isHighlight="true"/>
<Attr4VanChartScatter>
<Type rangeLegendType="1"/>
<GradualLegend>
<GradualIntervalConfig>
<IntervalConfigAttr subColor="-14374913" divStage="2.0"/>
<ValueRange IsCustomMin="false" IsCustomMax="false"/>
<ColorDistList>
<ColorDist color="-4791553" dist="0.0"/>
<ColorDist color="-9583361" dist="0.5"/>
<ColorDist color="-14374913" dist="1.0"/>
</ColorDistList>
</GradualIntervalConfig>
<LegendLabelFormat>
<IsCommon commonValueFormat="true"/>
</LegendLabelFormat>
</GradualLegend>
</Attr4VanChartScatter>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="0"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="false"/>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<VanChartMapPlotAttr mapType="area" geourl="assets/map/geographic/world.json" zoomlevel="0" mapmarkertype="0" nullvaluecolor="-3355444"/>
<lineMapDataProcessor>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
</lineMapDataProcessor>
<GisLayer>
<Attr gislayer="predefined_layer" layerName="Fresh"/>
</GisLayer>
<ViewCenter auto="true" longitude="0.0" latitude="0.0"/>
<pointConditionCollection>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</pointConditionCollection>
<lineConditionCollection>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</lineConditionCollection>
</Plot>
</Chart>
<UUID uuid="6251b209-4e1c-4cf2-9a36-f0083c386b09"/>
<tools hidden="true" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
<ChartMobileAttrProvider zoomOut="0" zoomIn="2" allowFullScreen="true" functionalWhenUnactivated="false"/>
<MobileChartCollapsedStyle class="com.fr.form.ui.mobile.MobileChartCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
</MobileChartCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="0" width="615" height="305"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="world_map_c"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="0"/>
<AppRelayout appRelayout="true"/>
<Size width="615" height="305"/>
<ResolutionScalingAttr percent="1.2"/>
<tabFitAttr index="1" tabNameIndex="1">
<initial>
<Background name="ColorBackground" color="-9782532"/>
</initial>
<isCustomStyle isCustomStyle="true"/>
</tabFitAttr>
</Widget>
<Widget class="com.fr.form.ui.container.cardlayout.WTabFitLayout">
<WidgetName name="China"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="Chnia_map"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="chart1" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ChartEditor">
<WidgetName name="Chnia_map"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="Default" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.75"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[New Chart Title]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Microsoft YaHei" style="0" size="128" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="false" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.map.VanChartMapPlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="4" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.chart.base.AttrAlpha">
<AttrAlpha>
<Attr alpha="0.75"/>
</AttrAlpha>
</Attr>
<Attr class="com.fr.plugin.chart.map.attr.AttrMapLabel">
<AttrMapLabel>
<areaLabel class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="false"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="5" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</areaLabel>
<pointLabel class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="false"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="5" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</pointLabel>
</AttrMapLabel>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrMarkerAlpha">
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</Attr>
<Attr class="com.fr.plugin.chart.map.attr.AttrMapTooltip">
<AttrMapTooltip>
<areaTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</areaTooltip>
<pointTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</pointTooltip>
<lineTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipStartAndEndNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</lineTooltip>
</AttrMapTooltip>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrBorderWithAlpha">
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1"/>
</AttrBorder>
<AlphaAttr alpha="1.0"/>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrEffect">
<AttrEffect>
<attr enabled="true" period="3.2"/>
</AttrEffect>
</Attr>
<Attr class="com.fr.plugin.chart.bubble.attr.VanChartAttrBubble">
<VanChartAttrBubble>
<Attr minDiameter="12.0" maxDiameter="60.0" shadow="true" displayNegative="true"/>
</VanChartAttrBubble>
</Attr>
<Attr class="com.fr.plugin.chart.map.line.condition.AttrCurve">
<AttrCurve>
<attr lineWidth="0.5" bending="30.0" alpha="100.0"/>
</AttrCurve>
</Attr>
<Attr class="com.fr.plugin.chart.map.line.condition.AttrLineEffect">
<AttrEffect>
<attr enabled="true" period="30.0"/>
<lineEffectAttr animationType="default"/>
<marker>
<VanAttrMarker>
<Attr isCommon="false" markerType="NullMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="ImageBackground" layout="2"/>
</VanAttrMarker>
</marker>
</AttrEffect>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="false"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="5" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" markerType="RoundFilledMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="4" visible="true"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0" isHighlight="true"/>
<Attr4VanChartScatter>
<Type rangeLegendType="2"/>
<SectionLegend>
<MapHotAreaColor>
<MC_Attr minValue="100.0" maxValue="200.0" useType="1" areaNumber="6" mainColor="-2081221"/>
<ColorList>
<AreaColor>
<AC_Attr minValue="=70000" maxValue="=5000" color="-2081221"/>
</AreaColor>
<AreaColor>
<AC_Attr minValue="=5000" maxValue="=1000" color="-1746088"/>
</AreaColor>
<AreaColor>
<AC_Attr minValue="=1000" maxValue="=500" color="-1410697"/>
</AreaColor>
<AreaColor>
<AC_Attr minValue="=500" maxValue="=300" color="-1009257"/>
</AreaColor>
<AreaColor>
<AC_Attr minValue="=300" maxValue="=50" color="-673095"/>
</AreaColor>
<AreaColor>
<AC_Attr minValue="=50" maxValue="=0" color="-336677"/>
</AreaColor>
</ColorList>
</MapHotAreaColor>
<LegendLabelFormat>
<IsCommon commonValueFormat="true"/>
</LegendLabelFormat>
</SectionLegend>
</Attr4VanChartScatter>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="1"/>
<FillStyleName fillStyleName="classic"/>
<isCustomFillStyle isCustomFillStyle="false"/>
<ColorList>
<OColor colvalue="-16765869"/>
<OColor colvalue="-23280"/>
<OColor colvalue="-15956794"/>
<OColor colvalue="-17050"/>
<OColor colvalue="-570035"/>
<OColor colvalue="-14395996"/>
<OColor colvalue="-12470356"/>
<OColor colvalue="-16765869"/>
<OColor colvalue="-23280"/>
<OColor colvalue="-15956794"/>
<OColor colvalue="-17050"/>
<OColor colvalue="-570035"/>
<OColor colvalue="-14395996"/>
<OColor colvalue="-12470356"/>
<OColor colvalue="-16765869"/>
<OColor colvalue="-23280"/>
<OColor colvalue="-15956794"/>
<OColor colvalue="-17050"/>
<OColor colvalue="-570035"/>
<OColor colvalue="-14395996"/>
<OColor colvalue="-12470356"/>
<OColor colvalue="-16765869"/>
<OColor colvalue="-23280"/>
<OColor colvalue="-15956794"/>
<OColor colvalue="-17050"/>
<OColor colvalue="-570035"/>
<OColor colvalue="-14395996"/>
<OColor colvalue="-12470356"/>
<OColor colvalue="-16765869"/>
<OColor colvalue="-23280"/>
<OColor colvalue="-15956794"/>
<OColor colvalue="-17050"/>
</ColorList>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<VanChartMapPlotAttr mapType="custom" geourl="assets/map/geographic/world/China.json" zoomlevel="0" mapmarkertype="2" nullvaluecolor="-3355444"/>
<lineMapDataProcessor>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
</lineMapDataProcessor>
<GisLayer>
<Attr gislayer="predefined_layer" layerName="Black"/>
</GisLayer>
<ViewCenter auto="true" longitude="0.0" latitude="0.0"/>
<pointConditionCollection>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</pointConditionCollection>
<lineConditionCollection>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</lineConditionCollection>
</Plot>
<ChartDefinition>
<VanMapDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<areaDefinition class="com.fr.plugin.chart.map.data.VanMapMoreNameCDDefinition">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[china_data]]></Name>
</TableData>
<CategoryName value="map_province_name"/>
<ChartSummaryColumn name="confirmedCount" function="com.fr.data.util.function.NoneFunction" customName="confirmedCount"/>
</MoreNameCDDefinition>
<attr longitude="" latitude="" endLongitude="" endLatitude="" useAreaName="true" endAreaName=""/>
</areaDefinition>
<pointDefinition class="com.fr.plugin.chart.map.data.VanMapMoreNameCDDefinition">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[china_data]]></Name>
</TableData>
<CategoryName value="map_province_name"/>
<ChartSummaryColumn name="confirmedCount" function="com.fr.data.util.function.NoneFunction" customName="confirmedCount"/>
</MoreNameCDDefinition>
<attr longitude="" latitude="" endLongitude="" endLatitude="" useAreaName="true" endAreaName=""/>
</pointDefinition>
<lineDefinition class="com.fr.plugin.chart.map.data.VanMapMoreNameCDDefinition">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
</MoreNameCDDefinition>
<attr longitude="" latitude="" endLongitude="" endLatitude="" useAreaName="true" endAreaName=""/>
</lineDefinition>
</VanMapDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="ea9f16cd-283b-4d7f-b24b-52b6e58bf287"/>
<tools hidden="true" sort="false" export="false" fullScreen="true"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
<ChartMobileAttrProvider zoomOut="0" zoomIn="2" allowFullScreen="true" functionalWhenUnactivated="false"/>
<MobileChartCollapsedStyle class="com.fr.form.ui.mobile.MobileChartCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
</MobileChartCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="615" height="305"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<body class="com.fr.form.ui.ChartEditor">
<WidgetName name="Chnia_map"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="Default" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.75"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[New Chart Title]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Microsoft YaHei" style="0" size="128" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="false" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.drillmap.VanChartDrillMapPlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="4" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrBorderWithAlpha">
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1"/>
</AttrBorder>
<AlphaAttr alpha="1.0"/>
</Attr>
<Attr class="com.fr.chart.base.AttrAlpha">
<AttrAlpha>
<Attr alpha="0.75"/>
</AttrAlpha>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrEffect">
<AttrEffect>
<attr enabled="false" period="3.2"/>
</AttrEffect>
</Attr>
<Attr class="com.fr.plugin.chart.map.line.condition.AttrCurve">
<AttrCurve>
<attr lineWidth="0.5" bending="30.0" alpha="100.0"/>
</AttrCurve>
</Attr>
<Attr class="com.fr.plugin.chart.map.line.condition.AttrLineEffect">
<AttrEffect>
<attr enabled="true" period="30.0"/>
<lineEffectAttr animationType="default"/>
<marker>
<VanAttrMarker>
<Attr isCommon="true" markerType="NullMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</marker>
</AttrEffect>
</Attr>
<Attr class="com.fr.plugin.chart.map.attr.AttrMapLabel">
<AttrMapLabel>
<areaLabel class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="false"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="5" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</areaLabel>
<pointLabel class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="false"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="5" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</pointLabel>
</AttrMapLabel>
</Attr>
<Attr class="com.fr.plugin.chart.map.attr.AttrMapTooltip">
<AttrMapTooltip>
<areaTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</areaTooltip>
<pointTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</pointTooltip>
<lineTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipStartAndEndNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</lineTooltip>
</AttrMapTooltip>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="4" visible="true"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0" isHighlight="true"/>
<Attr4VanChartScatter>
<Type rangeLegendType="1"/>
<GradualLegend>
<GradualIntervalConfig>
<IntervalConfigAttr subColor="-14374913" divStage="2.0"/>
<ValueRange IsCustomMin="false" IsCustomMax="false"/>
<ColorDistList>
<ColorDist color="-4791553" dist="0.0"/>
<ColorDist color="-9583361" dist="0.5"/>
<ColorDist color="-14374913" dist="1.0"/>
</ColorDistList>
</GradualIntervalConfig>
<LegendLabelFormat>
<IsCommon commonValueFormat="true"/>
</LegendLabelFormat>
</GradualLegend>
</Attr4VanChartScatter>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="0"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="false"/>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<VanChartMapPlotAttr mapType="area" geourl="assets/map/geographic/world/China.json" zoomlevel="0" mapmarkertype="0" nullvaluecolor="-3355444"/>
<lineMapDataProcessor>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
</lineMapDataProcessor>
<GisLayer>
<Attr gislayer="predefined_layer" layerName="Fresh"/>
</GisLayer>
<ViewCenter auto="true" longitude="0.0" latitude="0.0"/>
<pointConditionCollection>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</pointConditionCollection>
<lineConditionCollection>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</lineConditionCollection>
<layerMapTypeList>
<single type="area"/>
<single type="area"/>
<single type="area"/>
</layerMapTypeList>
<layerLevelList>
<single level="0"/>
<single level="0"/>
<single level="0"/>
</layerLevelList>
<DrillMapTools>
<drillAttr enable="true"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Microsoft YaHei" style="0" size="96" foreground="-5066062"/>
</Attr>
</TextAttr>
<backgroundinfo>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
</backgroundinfo>
<selectbackgroundinfo>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
</selectbackgroundinfo>
</DrillMapTools>
</Plot>
</Chart>
<UUID uuid="af8c207a-625c-40c6-b9f9-7b90002f3efb"/>
<tools hidden="true" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
<ChartMobileAttrProvider zoomOut="0" zoomIn="2" allowFullScreen="true" functionalWhenUnactivated="false"/>
<MobileChartCollapsedStyle class="com.fr.form.ui.mobile.MobileChartCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
</MobileChartCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="0" width="615" height="305"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="Chnia_map"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="0"/>
<AppRelayout appRelayout="true"/>
<Size width="615" height="305"/>
<ResolutionScalingAttr percent="1.2"/>
<tabFitAttr index="2" tabNameIndex="2">
<initial>
<Background name="ColorBackground" color="-9782532"/>
</initial>
<over>
<Background name="ColorBackground"/>
</over>
<click>
<Background name="ColorBackground"/>
</click>
<isCustomStyle isCustomStyle="true"/>
</tabFitAttr>
</Widget>
<Widget class="com.fr.form.ui.container.cardlayout.WTabFitLayout">
<WidgetName name="Tab3"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="Chnia_map_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="chart1" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ChartEditor">
<WidgetName name="Chnia_map_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="Default" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.75"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[New Chart Title]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Microsoft YaHei" style="0" size="128" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="false" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.map.VanChartMapPlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="4" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.chart.base.AttrAlpha">
<AttrAlpha>
<Attr alpha="0.75"/>
</AttrAlpha>
</Attr>
<Attr class="com.fr.plugin.chart.map.attr.AttrMapLabel">
<AttrMapLabel>
<areaLabel class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="false"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="5" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</areaLabel>
<pointLabel class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="false"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="5" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</pointLabel>
</AttrMapLabel>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrMarkerAlpha">
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</Attr>
<Attr class="com.fr.plugin.chart.map.attr.AttrMapTooltip">
<AttrMapTooltip>
<areaTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</areaTooltip>
<pointTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</pointTooltip>
<lineTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipStartAndEndNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</lineTooltip>
</AttrMapTooltip>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrBorderWithAlpha">
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1"/>
</AttrBorder>
<AlphaAttr alpha="1.0"/>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrEffect">
<AttrEffect>
<attr enabled="true" period="3.2"/>
</AttrEffect>
</Attr>
<Attr class="com.fr.plugin.chart.bubble.attr.VanChartAttrBubble">
<VanChartAttrBubble>
<Attr minDiameter="12.0" maxDiameter="60.0" shadow="true" displayNegative="true"/>
</VanChartAttrBubble>
</Attr>
<Attr class="com.fr.plugin.chart.map.line.condition.AttrCurve">
<AttrCurve>
<attr lineWidth="0.5" bending="30.0" alpha="100.0"/>
</AttrCurve>
</Attr>
<Attr class="com.fr.plugin.chart.map.line.condition.AttrLineEffect">
<AttrEffect>
<attr enabled="true" period="30.0"/>
<lineEffectAttr animationType="default"/>
<marker>
<VanAttrMarker>
<Attr isCommon="false" markerType="NullMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="ImageBackground" layout="2"/>
</VanAttrMarker>
</marker>
</AttrEffect>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="false"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="5" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" markerType="RoundFilledMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="4" visible="true"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0" isHighlight="true"/>
<Attr4VanChartScatter>
<Type rangeLegendType="2"/>
<SectionLegend>
<MapHotAreaColor>
<MC_Attr minValue="100.0" maxValue="200.0" useType="1" areaNumber="6" mainColor="-2081221"/>
<ColorList>
<AreaColor>
<AC_Attr minValue="=10000" maxValue="=5000" color="-2081221"/>
</AreaColor>
<AreaColor>
<AC_Attr minValue="=5000" maxValue="=1000" color="-1746088"/>
</AreaColor>
<AreaColor>
<AC_Attr minValue="=1000" maxValue="=500" color="-1410697"/>
</AreaColor>
<AreaColor>
<AC_Attr minValue="=500" maxValue="=300" color="-1009257"/>
</AreaColor>
<AreaColor>
<AC_Attr minValue="=300" maxValue="=50" color="-673095"/>
</AreaColor>
<AreaColor>
<AC_Attr minValue="=50" maxValue="=1" color="-336677"/>
</AreaColor>
</ColorList>
</MapHotAreaColor>
<LegendLabelFormat>
<IsCommon commonValueFormat="true"/>
</LegendLabelFormat>
</SectionLegend>
</Attr4VanChartScatter>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="1"/>
<FillStyleName fillStyleName="classic"/>
<isCustomFillStyle isCustomFillStyle="false"/>
<ColorList>
<OColor colvalue="-16765869"/>
<OColor colvalue="-23280"/>
<OColor colvalue="-15956794"/>
<OColor colvalue="-17050"/>
<OColor colvalue="-570035"/>
<OColor colvalue="-14395996"/>
<OColor colvalue="-12470356"/>
<OColor colvalue="-16765869"/>
<OColor colvalue="-23280"/>
<OColor colvalue="-15956794"/>
<OColor colvalue="-17050"/>
<OColor colvalue="-570035"/>
<OColor colvalue="-14395996"/>
<OColor colvalue="-12470356"/>
<OColor colvalue="-16765869"/>
<OColor colvalue="-23280"/>
<OColor colvalue="-15956794"/>
<OColor colvalue="-17050"/>
<OColor colvalue="-570035"/>
<OColor colvalue="-14395996"/>
<OColor colvalue="-12470356"/>
<OColor colvalue="-16765869"/>
<OColor colvalue="-23280"/>
<OColor colvalue="-15956794"/>
<OColor colvalue="-17050"/>
<OColor colvalue="-570035"/>
<OColor colvalue="-14395996"/>
<OColor colvalue="-12470356"/>
<OColor colvalue="-16765869"/>
<OColor colvalue="-23280"/>
<OColor colvalue="-15956794"/>
<OColor colvalue="-17050"/>
</ColorList>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<VanChartMapPlotAttr mapType="custom" geourl="assets/map/geographic/world/China.json" zoomlevel="0" mapmarkertype="2" nullvaluecolor="-3355444"/>
<lineMapDataProcessor>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
</lineMapDataProcessor>
<GisLayer>
<Attr gislayer="predefined_layer" layerName="Black"/>
</GisLayer>
<ViewCenter auto="true" longitude="0.0" latitude="0.0"/>
<pointConditionCollection>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</pointConditionCollection>
<lineConditionCollection>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</lineConditionCollection>
</Plot>
<ChartDefinition>
<VanMapDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<areaDefinition class="com.fr.plugin.chart.map.data.VanMapMoreNameCDDefinition">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[china_data]]></Name>
</TableData>
<CategoryName value="map_province_name"/>
<ChartSummaryColumn name="currentConfirmedCount" function="com.fr.data.util.function.NoneFunction" customName="currentConfirmedCount"/>
</MoreNameCDDefinition>
<attr longitude="" latitude="" endLongitude="" endLatitude="" useAreaName="true" endAreaName=""/>
</areaDefinition>
<pointDefinition class="com.fr.plugin.chart.map.data.VanMapReportDefinition">
<VanMapReportDefinition>
<Category>
<O>
<![CDATA[]]></O>
</Category>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<Attr useAreaName="true"/>
<longitude/>
<latitude/>
<endLongitude/>
<endLatitude/>
<endArea/>
</VanMapReportDefinition>
</pointDefinition>
<lineDefinition class="com.fr.plugin.chart.map.data.VanMapMoreNameCDDefinition">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
</MoreNameCDDefinition>
<attr longitude="" latitude="" endLongitude="" endLatitude="" useAreaName="true" endAreaName=""/>
</lineDefinition>
</VanMapDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="e23d8075-5745-46a0-9368-da664ef0e201"/>
<tools hidden="true" sort="false" export="false" fullScreen="true"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
<ChartMobileAttrProvider zoomOut="0" zoomIn="2" allowFullScreen="true" functionalWhenUnactivated="false"/>
<MobileChartCollapsedStyle class="com.fr.form.ui.mobile.MobileChartCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
</MobileChartCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="615" height="305"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<body class="com.fr.form.ui.ChartEditor">
<WidgetName name="Chnia_map"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="Default" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.75"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[New Chart Title]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Microsoft YaHei" style="0" size="128" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="false" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.drillmap.VanChartDrillMapPlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="4" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrBorderWithAlpha">
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1"/>
</AttrBorder>
<AlphaAttr alpha="1.0"/>
</Attr>
<Attr class="com.fr.chart.base.AttrAlpha">
<AttrAlpha>
<Attr alpha="0.75"/>
</AttrAlpha>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrEffect">
<AttrEffect>
<attr enabled="false" period="3.2"/>
</AttrEffect>
</Attr>
<Attr class="com.fr.plugin.chart.map.line.condition.AttrCurve">
<AttrCurve>
<attr lineWidth="0.5" bending="30.0" alpha="100.0"/>
</AttrCurve>
</Attr>
<Attr class="com.fr.plugin.chart.map.line.condition.AttrLineEffect">
<AttrEffect>
<attr enabled="true" period="30.0"/>
<lineEffectAttr animationType="default"/>
<marker>
<VanAttrMarker>
<Attr isCommon="true" markerType="NullMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</marker>
</AttrEffect>
</Attr>
<Attr class="com.fr.plugin.chart.map.attr.AttrMapLabel">
<AttrMapLabel>
<areaLabel class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="false"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="5" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</areaLabel>
<pointLabel class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="false"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="5" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</pointLabel>
</AttrMapLabel>
</Attr>
<Attr class="com.fr.plugin.chart.map.attr.AttrMapTooltip">
<AttrMapTooltip>
<areaTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</areaTooltip>
<pointTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</pointTooltip>
<lineTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipStartAndEndNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</lineTooltip>
</AttrMapTooltip>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="4" visible="true"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0" isHighlight="true"/>
<Attr4VanChartScatter>
<Type rangeLegendType="1"/>
<GradualLegend>
<GradualIntervalConfig>
<IntervalConfigAttr subColor="-14374913" divStage="2.0"/>
<ValueRange IsCustomMin="false" IsCustomMax="false"/>
<ColorDistList>
<ColorDist color="-4791553" dist="0.0"/>
<ColorDist color="-9583361" dist="0.5"/>
<ColorDist color="-14374913" dist="1.0"/>
</ColorDistList>
</GradualIntervalConfig>
<LegendLabelFormat>
<IsCommon commonValueFormat="true"/>
</LegendLabelFormat>
</GradualLegend>
</Attr4VanChartScatter>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="0"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="false"/>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<VanChartMapPlotAttr mapType="area" geourl="assets/map/geographic/world/China.json" zoomlevel="0" mapmarkertype="0" nullvaluecolor="-3355444"/>
<lineMapDataProcessor>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
</lineMapDataProcessor>
<GisLayer>
<Attr gislayer="predefined_layer" layerName="Fresh"/>
</GisLayer>
<ViewCenter auto="true" longitude="0.0" latitude="0.0"/>
<pointConditionCollection>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</pointConditionCollection>
<lineConditionCollection>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</lineConditionCollection>
<layerMapTypeList>
<single type="area"/>
<single type="area"/>
<single type="area"/>
</layerMapTypeList>
<layerLevelList>
<single level="0"/>
<single level="0"/>
<single level="0"/>
</layerLevelList>
<DrillMapTools>
<drillAttr enable="true"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Microsoft YaHei" style="0" size="96" foreground="-5066062"/>
</Attr>
</TextAttr>
<backgroundinfo>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
</backgroundinfo>
<selectbackgroundinfo>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
</selectbackgroundinfo>
</DrillMapTools>
</Plot>
</Chart>
<UUID uuid="4a1ea6c8-b419-432c-8090-e458d0f5a470"/>
<tools hidden="true" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
<ChartMobileAttrProvider zoomOut="0" zoomIn="2" allowFullScreen="true" functionalWhenUnactivated="false"/>
<MobileChartCollapsedStyle class="com.fr.form.ui.mobile.MobileChartCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
</MobileChartCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="0" width="615" height="305"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="Chnia_map_c"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="0"/>
<AppRelayout appRelayout="true"/>
<Size width="615" height="305"/>
<ResolutionScalingAttr percent="1.2"/>
<tabFitAttr index="3" tabNameIndex="3">
<initial>
<Background name="ColorBackground" color="-9782532"/>
</initial>
<isCustomStyle isCustomStyle="true"/>
</tabFitAttr>
</Widget>
<Widget class="com.fr.form.ui.container.cardlayout.WTabFitLayout">
<WidgetName name="Tab2"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="Rose_Chart"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="chart0" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ChartEditor">
<WidgetName name="Rose_Chart"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="Default" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[New Chart Title]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Microsoft YaHei" style="0" size="128" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="false" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.PiePlot4VanChart">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="0" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
<Attr class="com.fr.chart.base.AttrBorder">
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1"/>
</AttrBorder>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="true"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="true" autoAdjust="false" position="6" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="false"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="function(){ return this.seriesName+ &quot;-&quot; +Math.round(Math.exp(this.value));}" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="4" visible="false"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0" isHighlight="true"/>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="1"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="true"/>
<ColorList>
<OColor colvalue="-15118441"/>
<OColor colvalue="-11184811"/>
<OColor colvalue="-4363512"/>
<OColor colvalue="-16750485"/>
<OColor colvalue="-3658447"/>
<OColor colvalue="-10331231"/>
<OColor colvalue="-7763575"/>
<OColor colvalue="-6514688"/>
<OColor colvalue="-16744620"/>
<OColor colvalue="-6187579"/>
<OColor colvalue="-15714713"/>
<OColor colvalue="-945550"/>
<OColor colvalue="-4092928"/>
<OColor colvalue="-13224394"/>
<OColor colvalue="-12423245"/>
<OColor colvalue="-10043521"/>
<OColor colvalue="-406154"/>
<OColor colvalue="-13031292"/>
<OColor colvalue="-16732559"/>
<OColor colvalue="-7099690"/>
<OColor colvalue="-11991199"/>
<OColor colvalue="-331445"/>
<OColor colvalue="-6991099"/>
<OColor colvalue="-16686527"/>
<OColor colvalue="-9205567"/>
<OColor colvalue="-7397856"/>
<OColor colvalue="-406154"/>
<OColor colvalue="-2712831"/>
<OColor colvalue="-4737097"/>
<OColor colvalue="-11460720"/>
<OColor colvalue="-6696775"/>
<OColor colvalue="-3685632"/>
</ColorList>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<PieAttr4VanChart roseType="sameArc" startAngle="0.0" endAngle="360.0" innerRadius="30.0" supportRotation="false"/>
<VanChartRadius radiusType="auto" radius="100"/>
</Plot>
<ChartDefinition>
<NormalReportDataDefinition>
<Series>
<SeriesDefinition>
<SeriesName>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=report1~A3]]></Attributes>
</O>
</SeriesName>
<SeriesValue>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=report1~B3]]></Attributes>
</O>
</SeriesValue>
</SeriesDefinition>
</Series>
<Category>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=]]></Attributes>
</O>
</Category>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
</NormalReportDataDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="78afd27b-2f87-4a1a-a54b-96271f2b8589"/>
<tools hidden="true" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
<ChartMobileAttrProvider zoomOut="0" zoomIn="2" allowFullScreen="true" functionalWhenUnactivated="false"/>
<MobileChartCollapsedStyle class="com.fr.form.ui.mobile.MobileChartCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
</MobileChartCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="615" height="305"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<body class="com.fr.form.ui.ChartEditor">
<WidgetName name="Rose_Chart"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="Default" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[New Chart Title]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Microsoft YaHei" style="0" size="128" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="false" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.PiePlot4VanChart">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="0" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
<Attr class="com.fr.chart.base.AttrBorder">
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1"/>
</AttrBorder>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="true"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="true" autoAdjust="false" position="6" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="false"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="function(){ return this.seriesName+ &quot;-&quot; +Math.round(Math.exp(this.value));}" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="4" visible="false"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0" isHighlight="true"/>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="1"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="true"/>
<ColorList>
<OColor colvalue="-15118441"/>
<OColor colvalue="-11184811"/>
<OColor colvalue="-4363512"/>
<OColor colvalue="-16750485"/>
<OColor colvalue="-3658447"/>
<OColor colvalue="-10331231"/>
<OColor colvalue="-7763575"/>
<OColor colvalue="-6514688"/>
<OColor colvalue="-16744620"/>
<OColor colvalue="-6187579"/>
<OColor colvalue="-15714713"/>
<OColor colvalue="-945550"/>
<OColor colvalue="-4092928"/>
<OColor colvalue="-13224394"/>
<OColor colvalue="-12423245"/>
<OColor colvalue="-10043521"/>
<OColor colvalue="-406154"/>
<OColor colvalue="-13031292"/>
<OColor colvalue="-16732559"/>
<OColor colvalue="-7099690"/>
<OColor colvalue="-11991199"/>
<OColor colvalue="-331445"/>
<OColor colvalue="-6991099"/>
<OColor colvalue="-16686527"/>
<OColor colvalue="-9205567"/>
<OColor colvalue="-7397856"/>
<OColor colvalue="-406154"/>
<OColor colvalue="-2712831"/>
<OColor colvalue="-4737097"/>
<OColor colvalue="-11460720"/>
<OColor colvalue="-6696775"/>
<OColor colvalue="-3685632"/>
</ColorList>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<PieAttr4VanChart roseType="sameArc" startAngle="0.0" endAngle="360.0" innerRadius="30.0" supportRotation="false"/>
<VanChartRadius radiusType="auto" radius="100"/>
</Plot>
<ChartDefinition>
<NormalReportDataDefinition>
<Series>
<SeriesDefinition>
<SeriesName>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=report1~A1]]></Attributes>
</O>
</SeriesName>
<SeriesValue>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=report1~B1]]></Attributes>
</O>
</SeriesValue>
</SeriesDefinition>
</Series>
<Category>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=]]></Attributes>
</O>
</Category>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
</NormalReportDataDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="4ca7c143-ea55-4949-b4c4-2ab06fec22c7"/>
<tools hidden="true" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
<ChartMobileAttrProvider zoomOut="0" zoomIn="2" allowFullScreen="true" functionalWhenUnactivated="false"/>
<MobileChartCollapsedStyle class="com.fr.form.ui.mobile.MobileChartCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
</MobileChartCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="0" width="615" height="305"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="Rose_Chart"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="0"/>
<AppRelayout appRelayout="true"/>
<Size width="615" height="305"/>
<ResolutionScalingAttr percent="1.2"/>
<tabFitAttr index="4" tabNameIndex="4">
<initial>
<Background name="ColorBackground" color="-9782532"/>
</initial>
<isCustomStyle isCustomStyle="true"/>
</tabFitAttr>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<carouselAttr isCarousel="true" carouselInterval="10.0"/>
</Center>
</InnerWidget>
<BoundsAttr x="360" y="104" width="739" height="397"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report0"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="report0" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report0"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[723900,571500,648000,648000,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[1152000,2743200,2743200,288000,2743200,2743200,288000,2743200,2743200,1152000,3238500,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="2" rs="2" s="0">
<O>
<![CDATA[Confirmed]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" cs="2" rs="2" s="2">
<O>
<![CDATA[Cured]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="0" cs="2" rs="2" s="3">
<O>
<![CDATA[Deaths]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="0" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="1" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="1" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="2" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="2" cs="2" rs="2" s="5">
<O t="DSColumn">
<Attributes dsName="number_cards" columnName="confirmedCount"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="3" r="2" s="6">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="2" cs="2" rs="2" s="7">
<O t="DSColumn">
<Attributes dsName="number_cards" columnName="curedCount"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="6" r="2" s="8">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="2" cs="2" rs="2" s="9">
<O t="DSColumn">
<Attributes dsName="number_cards" columnName="deadCount"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="9" r="2" s="10">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="3" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="3" s="6">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="3" s="8">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="3" s="10">
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="Microsoft YaHei" style="1" size="104" foreground="-1"/>
<Background name="ColorBackground" color="-39322"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="Microsoft YaHei" style="1" size="104" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="Microsoft YaHei" style="1" size="104" foreground="-1"/>
<Background name="ColorBackground" color="-13395610"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="Microsoft YaHei" style="1" size="104" foreground="-1"/>
<Background name="ColorBackground" color="-10066330"/>
<Border/>
</Style>
<Style horizontal_alignment="0" vertical_alignment="1" imageLayout="1">
<FRFont name="Times New Roman" style="0" size="72"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" vertical_alignment="1" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#,##0]]></Format>
<FRFont name="Verdana" style="1" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-39322"/>
<Border/>
</Style>
<Style horizontal_alignment="0" vertical_alignment="1" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#,##0]]></Format>
<FRFont name="Verdana" style="1" size="80" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" vertical_alignment="1" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#,##0]]></Format>
<FRFont name="Verdana" style="1" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-13395610"/>
<Border/>
</Style>
<Style imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#,##0]]></Format>
<FRFont name="Times New Roman" style="0" size="72"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" vertical_alignment="1" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#,##0]]></Format>
<FRFont name="Verdana" style="1" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-10066330"/>
<Border/>
</Style>
<Style horizontal_alignment="0" vertical_alignment="1" imageLayout="1">
<FRFont name="Verdana" style="1" size="80" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<oFG'5+bgY1pOi<VF2p<WsZ&FY.J/(_mW[8Chobm%UdiG?#1f?,VssNUiL!O4i)6lO'FgCP
iCs[D5t"LnHI6Ot&?:7Mu4ans,"SKFg\q(IKt"b^Y63^"4jYoXX>R^"5Gi*ZpntkC)6/IcpW
XkIcWVrie:mnr&&PNZ0opo%U3oqp)]AkcN3(GrTM6sT#Z?0OE>%#\8_`a^&?^IIpsGel\OC4P
]AF']AE?cd5V!R6TSj-L1posDQW>2+cEDtGs:0t6iCo2VrB[F'+^ZMG]AF$@?B\F&I60=,qn^H1
R>5PK8$mHqB!nOM#983nJ71/T(S_gM0X=psJHYgg':GboB>Y3]A^h0$2`469:c`GaTJfKge'd
Mg3:`CIG"=c"3baB?Eo7[*=qr6C:ts3`;s&#l40S(!GFsj24Ho)*+PnH2$gG422mgA+bR08b
[BGV?)q0U*Q/9LT`rY;"IaF5BQ',dGf@@q@[#tm==#Ue6F/r\R>N(T<?Q:V?*\1.1b6;)AdK
f?u'4CHRE.TK[3&J@`/MTd96:U6N,0oL[Jt2bIaT[V8s9T'ACWBkRFQW1jnd&CDK@<hXbXN6
[+uf=8%ASB<eeK,UQ_F4@gqS+l00^*,gtBNE&@SSae4FPH6Tq8TKS+X&pSdN3CX">0faMQnI
r`0K?XRXi=F.@6"&*o*B!8S\_8Y?coTPVi-Mdp3Ah<D<DAbSLl0D1ki4Yra<5lE_tJ]AE97:f
:G+.^J"n16ds'r%@hWctF9=DoA@PRlX`7lf%\o2^U:a-PW'_O1LiV"-'=sY7Fpk$oP1[FV]A`
^>oXpX>l(M_QboS+3-du)W9KC6uVom*^2h%4h46@-8#QRf_b@M]AP.E0I%,bi>hu[JoO<9k-i
5Z+`pi_n1/.i^M:4qAS.J$i6F3RiYnlqOU6e<L0Qo4]A-CbK]As=dDMM)8UCn>tVf,0?-"4)(k
FL$eR/]A_adPl$\=pLLn9qVpgSZ.:&iCg0XcV19grh;=s.!Du(Um@.`DcE^Rq*.K]AF#3d7NMD
dbfaaj)4*N-l@NU4kN]AWh)3^&OJBA6s'EHu,:'/.M5:p)P.)P:W1GYocJ\_Ing*n)tV?I(^E
C]A8UXWP99!GO]Aj@o8`ALkOhoQ.m.>b<jHFnW.'/r@^;d_bg)A$j2b'pMWXCZs16MkALedPXa
OhW6/`1GoUHE&na96Hrl*&i@2lqL:?,Ks\c(T#N1JKhnS>=VLP`*30?9ta\[a^l'OEUT=,7C
RiN<r]A+REuuGQ"Cfs#Vo2ns@I62!t)*3IBLbT<AQF[:%#DlB_3>U0,dR+he.q8BCV&W!$O;O
j'Al_f5DXBE?"M>tS_)S7A#/nf?R=B;2,>GX[,DqZiOoeF27*!h9-6;L[X!H6ehN%7.,Z2rX
(Q'E%0`%M[VjZLIK4aX4;/CiCZc24JOiElH'?k2C*dXq$*0*FH<fSo:-RjfT"O,4%DEiQUp&
""#^1kBY-0T,N:ucR7Wq9)Ko_(<eaB9#!A&hiU-o%,]A,;SbN0!#e0\VHl5MMFc$PKL-+')Nk
UP3I^C0V9a<R-U5&HJU?rt>M9/H\oLlrL!aC:;=@0+K]AJJENo@$aOM6BmZQ^+$S[AS8]A>k#c
0d!*XX\6jENgL$tdKJ=t*8c%L%.THf'b0!MZ:4t]A5E'(EJZhbM%<I197(7p)lOt:&+>.h^7?
1/ZKGY<X=gl/lb;--_Ng/@fX6lCXIlHj`e2LZGC>$F.&G&G-?rd<`[[Zb6[W"kooQM(&3HW$
n/E*2%%*'-al,Lg!qOr;s!G6B+&%fAsEP#92]AQ9&[rKMfEh(rR]Ar-2IT&B9K3:<j?'Xh:.j]A
'nU_#pJasUqp6'pDK-.4R,7II/M*bI'Nen`Xf;nkJqNId,K/Ee_#P=T0*t"+Dipl?(]AVI(R?
d)#E%>@MW0\dii\tZi]AppThBOBr;<.0"IHmiFORR6R46as58,>&r)6XSOP[\a,Ohu/n:o:&)
(@>qE:cl/al[W\(Q6r.>+@16:chGHh_13j+a5K9T2^Z*#Pg%n.m(O(<a6Fq^H27(<=G/.]A[U
`bT]A[J/ElD&.#tmsLW8K7,CfjfqW"TYj*2*@;41rit=!c7#o#-]A&P'L,'KTrP7@Va=AgM3=Q
oGn0M?T>-/AnE\nTE.<2dVD"JNUnpYl`eROLZb,_-!6T?&SF!t!>2PWV\/5OiJS]As>5%I6u#
b"uIU;8>Rnp;'f,a,]A3o')..h<,+gtOE9)]ANsN1OBo7*(]Am`^5aQ)g++i\RskfC=C9;l#*gB
dP_8PU2S_Djg]A*%U3g!`:[`$A`M^H!bpR7$^_&`>q=XWnSPKcFpgf8=^X:8-(CJ.\oL0Mk`X
HMP-]AXJK]A6X]A2GE7hTjVd(JlW`mGO<3X>nW/3S1g2L&"bOb>\I9*mI4'Z#3:-OMlO2)>/a%#
,O@N_RsW?]Ag1ObkE1e>%LkC1h'>Ef/Tm7W'cGZ"@Q.MNF,-q="%-l5J43._8>1RH0%d)"M+A
ec9Lu^MWq@Fd.1ke>gm#YOHJE2DosWZHU2njdVTMu;dc<9jgo'`bl[:cC<b04^*8.JJg7pU'
7I23?TD!$N?G4/5A\b!='K)=`_4X*E2d'VM<H3dh+kO_k&_p[THb=H`LU0WH8uu[9-ggq+7=
rfk\,O7(:QRtYGYZ's@Si:JlN%?I+sIXapBrZWhQU(6l'(4rS!#9a*JN\dAbEk=dfo[ijKDb
PFk"i@P:%1$$jIQ':A32T(p>Tf:EZ_R9#8<P"M$i>BJl5o.+-d$S#r50qY:gpAF)/%bGWXH'
Q7<5A28eL:8r\.\'Ejc$(#[04[M0Ch5[X$U9KRs_KYgGi!FBcGIQKHY'[<(1Rd#$kAs3R&-S
m/''m:NE$oZ;p1E1K6&booQHGH\d!GMSQfnlleN@O9q]A#SJq++$R?8&=VJHuA=\Ha^;[A96@
73TfjWL%_$2R1o7,>f1_GHdl5&*jZKVW&"#Ma'UlDs6'S="A!"aBEM?";pdTBun`YLCK`^_$
cY\F\\7TWbuToU<Q6E$@urg`q@t<G4$j'm9=Hk(gENhmU#=GLa[a@qUZb8#35iCXS^*@haa;
]A#^9,^;<@.m0boLcZ/!aqlP\E)h^T(--BWr6bOSq3(2cLS"GI6']AbH2_\gc[k;+O:A3gH/UR
;%1$D1Xe[#9?%`CNbqVQD[nB0UnaXWAf]AW;kB&f8PaugB"q1HLfUN"p3'Y\4AgNPq`-L8cXA
6a%m[AG>n-CB;/_QnjH/>`l:Vb$Ia;mL=/m#'%EO-%oUoqSmfdWtLkb>\m<B%5]AgG-4m$rrn
(=3/kLu+62F)KLVhic0C)<lVXnW#+hd_tudYUg,g"04=Tk!_)aQrY;'LEVOCq!0iMr>Ys7+"
.WQlkbTjZU4#Or/l>ujjn'H_+9X<gd51=;911`hT_MCmZu2DdE+a6]A5#(W/DTdLTKJlOX4er
N3,lgQcRXDXc8A_DFU[uq9a6bS#:,8(a+ZR;Nbl-3ab[Wc'sY0%$Zg.M/dqH=X/GTE6\(cpi
G?Re7916WlE:q"U:Ml#c?k9p*1?\p9Ut5(H$Jhi]A)MXkes9b`jtPF-)Pb3&%_*OGeA3f/#%t
F^3m3EsH<J[hkMR=+mT+S*,[3]AeG3`Ep8ef%jLJ!r-`=(<FS?0sjWV@Q$Q`:gP;>PueT_nK1
cW5@@qqg*?UecA&*]Ak8YE)Knb_K$CR[8W.nL)%#RHCMUKC(YMN<R*%Po4`]AW2dBjqPScJ`#N
/eG\.8iH_cCJqbG)Lh,"P#i:'4n(77@La2Xi3C@c::(i_Un#:3noNak/'?N#"jI]A2S?qHs[D
%\-:bh3$4Rd7("0&o3<hhS5uUN'\BN:eQK6iJn[lWcm!?qfAqWbIZ4gl)*#XJl6>+@^:0pK\
/h2)Xq7+tOO_M&]An:W`&V)9b]A`!stBt]A2iTkH1<_IJsLk#-S`U;a&EiF$f$)q?)5d7aDnp]As
HuQ"6Xn#ttRlfNLme^D%aX]A;e'T3mPQ>B;kM4s2<[HI1YNUX29d:]A`g_6Fe]A-;CIs#SU>5%s
J(>aHc=RU:c(N/^L.Z6K[*s1n/hpOA+D;>g$6sZ"jtM>-T2PT=><fBjDt3q5TE!K(0LqBsHP
(rB;8?ruG3Y-:CifrnWpUZC6(h:@#$CD`<a)ST<e[F_j*81U#jslq(cZfUdMa:*bQs>HlN!;
gY6XG5>XDS-'g=5bDXPQu3t&`H[=<iP;H74"4`Kq!^9H1>18a9$\n9dL9gROa@6^#F;,R'!)
WTk!I'j`Ig-.4fD-c]AV.fX:nfj"Mmb,dU@eKr/1_.LdBJ#>5)C)m1%[nQl>-bD6QUq%nBX]A4
1ANmqQ2!=RS#'aD9ME>(Xa`<#ir-@)F-7Er5ITrZt\#Cb(Nenh2AlE;hT"0UU/64-`Po9MnQ
S*bL<XK3sb_g7TZLnsQhZ9m$^*_P>0jd`+$%JFM(3p^09.U:0Xb1_d5VP;H=3P#]AAI#hGK2g
qUJ]AAO,^lGV0IP+cLZB1%=:lWG&s#3C$9P4nfr5VTIF95Wh\UfOa?b=8,E[InH'&<N,(e:f;
qDPrQT=9i$ZLB7ra^f:gRFd1,Kl$s9k8'eurfdL6W&X06,A[;okoq9tSlt9f-/)C2#GSNVD6
\8o+(MlAjkRHgu+`0E6[`]AqIpHlSs+;C=4qd>t;P5p(]AZF<aAMkXGa&RAhFL$el-CQc-u8mA
ph3-+c+F3(24e8Plrf,WU7`s9juo>bPIFV,4RO.iM$NGA%@.FUmU@Y0.Tg7ALT?UD1[o`FUP
%'cd^f?5s/Z:q;J7WRYHBRXJ2q9]ALn]A=u5+`eght20m%CB::,<e"dd\ofpHp!hmQE2-LkjDu
LnU@F_e\r"c96WPs,i/s!gt[-tif(j7$_%OZsDocAO<A!8<FQbA3dZl,#62WL`N\FA^D=:e4
:=f.-88toU3f=S?\;Ge@3p1T9ApeK3]A1NZg,BX+C!fYICcH`(>`^Lin:PDR'94#oZU/Q0Nc'
+5XMCG4g7/B*M"mOhKDk&nF<K-5t9FN(c-H4.9YLZh]Aq<cXH)Wi2rCD\YcEO$=+O%RMc$pri
-ASjOr[jos!lJpUD\j':u?V$8tpkeo6:+)E?Ub<(090a%\"5>JhfWqc#.UIU&#.^`8qT-)Sc
P&!@`Nm6RS,TYubi]A"/um*;T/I?GH;kqG\s)X$E<,2@1>K0%-%OSZAZ*#01.KT/g0@]AlG\bN
E:TZZ%^Zg,^[&66Cl=Sd(T!?V'SZpFm]A,[%M>nc/QJ%46p^h+)K<(.WT3j*Jc2*6`RNo6Xc$
41>U5bml2Q(o%+RY<*$.U_CVs`2)n??YrV)`j)Tj[.1sAr%I%6._lXQ;_;\&`nNaB%>,+u2p
rJ[o=t?e[B%t9n,F0'5L&@71TBH`1&Hb\^UGmETBf@Un!!L%<.91`[R*iMS*,6U(<"r"%;3/
cV1O!"sGn@/4H[<[-AVks<4\pl0J$:LcMV%#_Vhf2NFJB"=EXN1=q>rQLK^NoIfGBDrEA-_A
d#NEHSM!_^/"T._YF-h.EB5\/U-i(NaeY%LY1GUBo'Z;O0f7,FZN)>\lYm#P^Z?#*WD3Mp.)
/e4,]APP2;]ALdSof3_a)4]A`".9(%MLn+4>c@"+&1#iU;2!l>a0un-c_,,[U\_!G/TWg7g0K(Q
80#CY!Z55fqopRWi1dE<QiI0(i.%_jp/BEYJ,q0`>g36PKV^l0`l*WL0_f9>B]A<-7/$R0)g2
4qqI.fr6B3q>RP7SgJ=`>i1tb_]AQKB0!EW1R]APnRQ)3tPZ$k5B)G)2V7s'7+c$M^_iVX^Vh]A
ddMY:tLIuacB?E*5;JL6hS58Xk)9;&<M/D=I@#*q?N-CPn<X.c6SLWg+/e7dS?:5duh'A@Us
iCP'P(N"d.GmMFGdDM5"YF0)`G@==hPRD%3[4A/$47`!'.r`WOd]A<T_fJ;rLdkg4U7l5o<TA
?HB@4is3OG23Y*&&m`F#Xo`b\/n<:JlR>f>tluK#pHCAdR3NWO:X8E_s^G<&D0$D3]Akr)tJY
Y;C_f"ORJ?PVftfXB@a=L!79_H@I8m$DB($tj;))jeZ=\K^K4UI>*CdsoYhTi;0g%;%La))b
A6Dl**_&h?2.;KCY@^s5X8=-69Lo>aT[+t]AX@4n=00Cq^`"Rk[B>`>d@.QI$j:l0b#NI<L=U
c5bp82?]A^eMiGl,15)*u^RgA1n`$)^`r"\im:65Z3@BM?&)Uf0XX,ZuKEe\u>_33_H/,Vd/2
?T'n0`^IcLm#5s*m7!U&H!]A!"ZpgZ?5Kj/5F^k=*X/rqF^ok9@h/u)i&.P[5F<nJ^>JkuAS4
\$X4rKN'ZO;pk[b!G2h\@afH!A[r^c:2?c:4LL+E<34>0H<VreG+3NbqWTZ3Df'T3lWp#GOL
+SD#VQ!*^OD,hT+rGF4_k=-7r/@2QC3pd_QsfLZ$80mBkfP"QVIls*g8nX!%tj>6TPXE_EET
Q*PG$9X0nF2"ZLkE%,G41_FYF]A?R$[\gKCdt6+#<>#IQ.`]ACGbq_d8A!"[Tr(/stZc<Zd+HF
[NpZ$Rn\[jBFHXgp.iC7%d3!]AMj7aNqY.JgRQdfCTdFc*jtW)DK.<N0KU^<RM`=.h^b/rg==
4Web;"t0Aqr2q_=OB4D!?T?TfZF:0f$#6@1o'URt8n!&X+RlhbWpbfg47%/EZ9)4U7T&djVW
_sbh?SZAq$41=4[OOSLLfch?`5[:U*5\7RCoAtR*AO`llB(j(F3GoNJIo^\(P\f6!SE.W,QA
gbO,s'lgF#?R8<ZkY"3_Y+B=Uj8DU@+BYu1876:_IlO=,JG)-i4M^`efOa=no%H`WS">WUc;
iehq$2,hY$^[c"l>Hg>C>2EcWI2IGc-DW_F10sf71[3L%i<u?AYoZR]A?2s=FBOjO,>o?fLGV
3<c7$+Sel.N=g!@O#Ae_8sXQ/gn[B=1r,%cMs*$2>l(Gkq82TaST6+OiLRT1<kE?1-7"8"4'
THH`*pG^dl+(U\ZX.<Is\>o]A4R'3GiE_Ni"7,M0>>34sCmM6(.1oiXbe,0r;\U^\:K7RG3T[
aIr$O2-*ZgOm__kK*Ckq_\GZb!X@XfPc^MZ;Ci6=BnK)?SKHNBM7p5hQn'F>9)%4j%!Le:%4
!Op2Ab---mSe@SO^&6:u8b"m/d9Y"Op0*QdLcf5"qAD3\Ki.fe.)ifl4VV>]A*9jYkMMhBIY/
=.Dh.C?4k0t0\PG'#N4+!sg#cZB1dV^Njp98bYG$;O@8<HYpR_@TYR&%Y5kP4Ne94T7j43l,
E5EMl#"*CUUP<UBg=kF77K=eDY<C1^iL/)/B2pD-_n<l)F^@)dTQ,KY$4"lo1eRp3%3mYsQ0
c7Rj6gpfC=i6P32OPNaRS4iZ7EYCH6Rhbk'>hmd>N/%eQ^':)tq.jN&TAoMX4Nqk>/?YDc:P
]A^npj7R6RJ.e;6gMJ'po*]Ar?^EVTLgt1Q#2R\Ud"eEdBrk`)\7m.UNe/U&G"OoSn:]A"k]AE]Ao
14)L'A,q:je]AMN,CcSi]AU4dm61[\ZIOA-9L:O$OFo'R)6TbIjghnd'<"[1,B("o*d%r.,7^V
kPfqWf,keK<c\OWNJ*/VL48"J05u;k`]A7[5Ua0i:1IA'qNV$S3]AVG5!Hm?lNS,eHg=Y&rErX
P>l,r%(o^",r:UO"9l/5@Jr3,3hlV(S8.5n]A%2>Ae!OTGQuRtKDLQ5ANC02^e:/iMd%YL+<9
2M<62cGo6oJ$/m4c^&iRh15=_5ha.L8=:T`(34%"eY9!@7s!*#l$M"a!I1>BQRUt+CD>13ah
-7\GB'2Nj"B4iHY:)SHA35)720XK!MrW&XgJUOfF&t,I'/?aeOpWoSY'J9olD+P*"?KL/!c8
d7AAi2l_0_0[?]A$*La&KcE8JYQeE5A<(`Qe;bni]A&mfcQh8o[l>@7*nC+o)@o'cdoe%YQVNC
M]AtF@B!UOFTndY]A<&9&K$!n3\mgXNeXA%hF5-R>Tk"YkE')c!rU-L:U@FiCV.-;o4Cc(YXuF
ih@V;R:/g<)CEE!K:HZGS5]Ailk[^TKP1740XR0%LsO1$&*X)Fe$#B3&SB:)ug9qX@<GX8gV6
3b*h+=rdYIW4pZUb+]A)IP'>-_9u=DGYoh@-jFO@!YedB#&u:2\eBp:&K0q5's,+;_7aam,X;
.;(KIpSKl;(sRDU2cM?RquiZ_\MP_KTnejeK=[aa85%oPBPb>20LsK&(V!ZkibO0D`_0KiYn
AZZ$C3JkF$d&PZGQJIhjoVt/k.nX2/c[X63a-&kiuQ9"_@70aGU4qF8_L\s]A@=ECtRhS._,A
lrbD!A9J<Jpm2G]AZ8]A2:o)huMh65J[#f;9L3EQ\^$X;7oTtL+.'>Ysi>8FBil0JqrC[@R_PL
4H>OU`sC2kp('$K[]A(NClbFO!4fce>Km5aii)^rUI(/@p6AWu7^Nmq&d$14lLV?MkC9iOik)
%D<6r01@6IioX3^`5+HkbU%10lE1rOkK)cUPL)BrIe8B>k3N$0l8XJ4]APbUfM$\4d%3c92mH
DonkXS:q\0*KU`F<%<)%+YuIHC60-$k42\^#ZOZL;CS;Pcj15b5'5`?#HL5go]A?N2Unoj8(s
Jf9tZ2!!7F7()$d^!#QfIj]A%UMC^$oHW5IHt:t:;_ihkdA(;=_#k=SE$T;5AW'Uq0B]A(&!%-
#K`!09$st=l"g8@dA.P@aWEk((5,>LH*d-2SOO0s7hSEB6O.hVel&J+\6Z\=2,k9IOp^E3Rm
D56fDOeBbaaT0Qb)%Pg5DKLOj6#HXJW4UilZfeQ\>0;=rB\O>o.jT#kf/aV1hmfuqS3pXD/c
Yp7,5@;(V"6]ABodN4Z!$1$Unl_>7d.*;0mW:nBEX*tV(MW%A@(,tieA$43-76q:Bl5BgSp(;
@og((iP$0hsU;qU*W*9sC_beOKc1doAgpqj*i)#ZFlt3(9.6BLC<+OQFZRg;01N<T@7kF\Pp
qcGX`OZ[<C(MB32BhN*OEc^*[-lEG>!.TX*qH+/dhRlj.#Adr?JSan(UB1H3g[4:1dOA)]AgY
rlmD)6Tln)'c=S/i/Bt-A,=O>T[Ce=!4/oZT:=o*a70KF/'D0hSRkJ_M4&ijO^,CFfWddU;B
6F8XeM@n=sG'olF$"5D,cTd^tEjmlR([<30`>mUd^B95<1"3g0=ZW*0;[NeAo#[dae1/1p)Z
r+m(%!Q%hKM,\#(G&c;V`0]ArtjZ@igdEd]A0rd8OSGs'@'Jt-oLj8T.#`*Zgs>#i:TKY3J%Gn
JZ"2>!kNV]A8(DV?t;C$u$J!_`b`-V)K$QTD/?7\ALIbXipLBAfR4M3D,8=kh#f$B<'X,,47:
u24W8J-%!LSa#KA2,Kf@uglCrpA^c49B)H+S/<^uB5#>e"XQatlGKcAae:.f#mg^bWVDiU=F
>S^Y-ba*i+tehc[LBo-S;^*nJk+%i9"!U6qmVl[RWF2-remPL\NOfjdfZS?k$@l*2cu22rel
;S,<BV97*t@$/")_NSB>L`IC=i?*Y+;M_U1lE##(:df(Y-b1a`c."&pQLp?9dob#os:@e;a%
2.5/qnE]Ah+S1.(<aa[_\;_6@ZO*jM(1*jUHD3l8MlbCAo\r2nL)%elmBN_[6^jnn4#ZQm99R
ZZ%5$W-H_tL=`-FasE9[+$L7^;3mCQ(!Wme%.,C9^SSk-A;T^Xf_^Db0V0U-+@lp(7hc1%r\
+DimB)]A_7ds+7kY7=idW6_ZXQa#R!BqVifP(VeZ8&Q1HI!T^Cidr%4"Q`TVO6W`l.qLfbp#W
qV?cIm3]AM--6dTr'C,85N%%P%F(L51;ea:Y]A%5L90q\Y;.bN4^ZMKtZbLgWQ'LIDDBKY[Tf"
$;$DFub^-a6ZZ<O=NiuG?6a5`PJHCYtuN(gSi_]AiNuW&gs4'L4Jn[.AR`Y7ZXI@nmKQSni`.
iNG:U?Li&i./;@DDo^@n`\#ZX-q^*me;#bhZJ&JWg+ItNjk<"KAYo@U$)LEGR`UNlX_59FUp
a7K+mM%(F7LQe`YR<=c6.oQpn&kON/+aVGD<'a4h8,6XN5dPf)4#`]Ac`iFmHCL,PRu:D:tHH
:h2UcRj-u\3&107<oIZ`ua,Z`V]A>]A&Opc9pG%Y6ocd=/;U<CKa<n61RhM:+R18F]As#(O+_bM
WFis!A15h2X?D]Abc?!`TL(j@>:]A`Ae:3G4T1JMnHhtP5A[>Sl5#R0>'eQphbg<8c.bEps:+^
E1&>T;S"[]A&snpa$n,<T@Ch)rmPfBUh2iDO.UQu3E:."?`D*1dr-i"=bL((m>%d-]AN_?(Z/Z
)R$RplD'$ZVjXhQ\H+XFF)/8=#86DDTq*#E4R7Gbq:d\n4=,f6;1XG9'3j9a&/19"VtSb]AIE
J-S/C!YS>Z\ZHUg5!FT&i0%mmtY^80CKDA]AGhafpTbY/2a[Vl.+R,@XE)^WSU%QI$RmDKFGj
2Togr`Ig`W:5hU0tS5Ap;B4U<-#ao]AK#hMqca10-Vjqu)EJbOXq$Qm!T8n"<Qh`>kGJ>;jNm
(kXf+ag/5SUs(oR)cs:ES+'IE<5E_AXg%3h\VBG\L70G*3ps7n\CF54n!-U.7R*ok358,lN1
KqQ7iI5Tl1R'K_$cGY8Pe?aTOW2YoAjGd1!]As,Ct27o`eAX*Dh/ZTZ\&Q5X%[EiRG[292lSS
bTN^A"gM.K2L6<hpXu!caV!&#h`V(_s"Jt6=]A+p!kttpKI=q<&g&>c*XtVCLSihg0^2j!#6a
%%@G),FoB429)I#N@8bC,RrfDePmKLGX,J8X*ENflX@r32"Ero4Yqdb'lk+8oW:#L9lO=3^5
6Vt$:9V[r]A\<U/:A4dZ_K+o7,8,%Uq#)WUV_V&Lur@YnSVoE1P.rm/+(L[?;j;3G;<4L$4?i
OJ-Pfgtp<(!nn15R2Bg^Y9<0HZnW5a]AB?]A%j1YpqAbc7F,9s.Wd+C+GsXY+@NOp@\*>AC``S
CRA4u;1qu/T.ho!IHe%Ge'X5.8-kejca"OFg/Jsb/^Fh=8tDDtcHX6!_D=c*S0;>#IGk$(L2
mp27lA7#q=mLiahNrN<HD`gt&L3RduM8.Y&;A0?R_He90?$QX2B9;o?Y0M$=E`U/:S3j<#CI
k&6-Bou">P3^qKNmB4V^ai("-Ks9.'Y$?1<nBGI)_tRL44"3K6&2&P\:S'qVKf%`N.'^Jkm=
\m"kdNZ<jN]Am2a)ro,1a^G^L)\Igpto6CtE?^CdI[f)C3Z_Xh^3%7D\P?Y37e<tW'Pf4Mc:k
sEr54K!"e36;'gZf]A8+d+l,or'?7X[,0kA@LZT&Q_2pu^*1H4`g&Jl$(;f1/"t)*2"n26M;.
WT340rNIf&g/>bbP_kHH?Y<9P:P[J;8W)$0m0jnqI1dbb92WfmR9-P3</qU"g:UP`ggL]A"up
2Yg:5!.4\35KaM8':q_`eG5^akpr+Th3qZ[Jm_s!%gWf_haE:aN6#c,(t4rRNdg$!2u\9H97
M/hlMaE(Ielb#RkqN*e.3o(o]AFH_<Hfn86[o'dpNGO(ng;%Y6\(7I>8?PW_G^EB[H",@2LKG
?Kt$7p>L*:T/ad]A!&_&IkrS]AicDgDdTM_sJgG&L)n)EZV6<HQ%b!:N1%=0D&=)92D:ReAn"H
JKmL?At=7m<MW+dJYmpj52['DOC.=mqp!O:LXU&>=S2V]AgugMpG"rbrtg?+>sQqdgXl72VqL
MVd@Nd0QLCUKD;9af..Aa9KFD&nNtOn)^@2#L]AlF44hDa`NW`X(->24s3VoRpCW8;d/@8l1'
c&`eeRER67q_$]Ap*<'4#ZE,K"=BqgX'QJjBPWulREJu^gI@nUW^D!U$=T"XcNL]AY.M[<LE-I
sl1<>8sR6%>7TO'%*^,bC<o'6:Q3+%%.LLHrX7qIHH(9YTU_^O\3=-4G1L?K(+pnc.CIo7rK
+?XGsgT6]A4;9cZ7j\3eH*fmCK<V+qoY$rBNMX]AHlQ6u<ds3M]AMOGnrI)+Lk^[IF6[PK[<21]A
:P+"alGS.k'5W?pRaHJgp^Z4c7jm#*9LZ/(75_o,4bq(Z,S=tLNU9)6SQokb8"';55GG%V\_
C)f3f3?L<i@#P"dhr'17RMUa6R[S686jf_C,63i)6na?Kh#lKXnSFKHTABSt=%qt,_`Me'kX
2gUKUfd^49.M/73&rAjfjE.:t*DZ\1[(?fuFX[.[J%ILt1"IIg)bcu^d^B*+iJ4uc\GV!Q3U
)*JJ!s90dEZcFfC>2Y#YY9HG[cUVAM]A[@lZFppY:spOE>m,o78ss@h(DqG98^sE'4a]ADRJ5O
`S.S/0d@<=maLA:):bj_8fY2V_7<X%^Oe"J<i10^qQXF3XU>D='(qNs'I>3a]A6.g,gbk64Fo
X8UqV^T8>GUpupHK*:"BmU:.?6Z<UN3Ok?J7%:F,E.VR%E]A.+Y9r=unUZ3#n\\ik+a>^>Zt_
<-=uBRAg-Hi!l'$B#"@-<[ln_9,5DN,s,Tu5'M@@8c/Kd=!mp(F/<s.@$';c@O<Qkc(Dg&aX
KYTteqP&#"rH+'gR'Nlp?H@=;7h&NP7U=dRV-s>2,/VJ`+cm>F)CJJe76'FNcQbmsBgIVPT4
-bo^da6<GEeaV9[a1D$M80Z>%q\:cgT7#Y_ck%PcA]A&Vbi1H7e_Yi8U?s*N3Nl!]AL@eMaQB0
X5Jf9O.08*Zn'3b[G-)oanre!phL=L$@]A@^:M1\"dX=j1\^Fl?^@f^(O'L.5U/g9;:<OfR'T
>X44QUCD")2+7K-d.u]AOZB2#^8@>B1!tB&_r;)AZHf"LUHJ_!1LU.(J<>FR?Y]A^<?CFAihKK
lVX:1*O#gWYn7O*R@&CVOcqJEs\.Um?^1eP`lBADaNckY4,:C)!=l+3Nj(r@Q[*><Q.dNNIb
`G":ElqbXNd]Ap,S.bJWToEL'Ln/)rjR_BYS3RK\=66EV,n]Ad.jOl\L(EZ:_F.p!DGRPo.ETo
FIehG2Qg@\sY-Egt_=4+m=1736jT%e&!<)8q#_[hBLYC;%IMo(6u.ksVBAX%N0_CG]AijV=l[
L=qnJFpAFB9OI%&N-+qiPkFE2QRKd#@.$0/+$=`#J?R-+S5joAf3[dei(<_PO_`T%`o5TF+^
XleY7P$fDDl@7s5'iMPrmrZ<)o9Z3;,EV3cCkt!$?kLobX<1,`[1GDN(-A[L(W&dl;S1KR#B
2p2%ts4rq(N+&E.q%iKS:nFnHs\;;>(35CY#GCOZ>s#G:r.4SVV:dtDsqIADn'..UKl'C$]A+
-2VM$bO%u>4-=-Z?Vl:K7hho=QMTn1@ghm^+JRUUCa)T?LU9+1[k2^9fM8B%%3Sp\&Zr+VP6
KGJlCt5^DF4her]Ad,dMa,jk2!ZOmPKd&QKI0qLZnI'k4>?]A$pjO."2\SQ<&4K<P,*X1VjrI?
m4-T]A\'bEtq4+M]AFqHF(*"'K$;QP^$t1H/ALr.aYEOb6K;_/&>b'I7?c]Aa`kT%>p_DKW8/JR
Z4[moTM8j"Ek/g*STEoK)I(92M`]A)NPnHJP>/@OIGO(o#N#I<@iaXeiNN-+W]AKhXS)'@sbNp
NW?oR(B>>fa,cR6`"GDPi)c`>%6k37]A`"?_6sI(smSM._oW]A,S^Z5[m^>gIr!4+EHo=#N3IK
5*A0N$n#-==>k@RPW661p!\MspB]A=HSrhD4NQhsZTMG`F(.nN$)\pH\#;CSqDe?orJ"skZQ0
8&M5H/*tK+@Q?,*8bMR&UO_anUhAa\omp:eX&.]AA>6MOo":B8c`+1kU"qU8$@UJH2aT2UYR?
]Ab1`a,KlK\@/PL6rhZtE#_aPtih9:'TSai@B#s>7cr?-$%P?tH,hdo;;luDfMDuX_BD_$:Cj
b*RD~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="300" y="0" width="615" height="89"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report0"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[723900,571500,648000,648000,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[288000,2743200,2743200,288000,2743200,2743200,288000,2743200,2743200,288000,2743200,2743200,288000,3238500,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="2" rs="2" s="0">
<O>
<![CDATA[Confirmed]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" cs="2" rs="2" s="2">
<O>
<![CDATA[Deaths]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="0" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="0" cs="2" rs="2" s="0">
<O>
<![CDATA[New Confirmed]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="0" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="0" cs="2" rs="2" s="2">
<O>
<![CDATA[New Deaths]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="1" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="1" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="1" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="2" s="4">
<PrivilegeControl/>
</C>
<C c="1" r="2" cs="2" rs="2" s="5">
<O t="DSColumn">
<Attributes dsName="number_cards" columnName="total_confirmed"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="3" r="2" s="6">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="2" cs="2" rs="2" s="7">
<O t="DSColumn">
<Attributes dsName="number_cards" columnName="total_deaths"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="6" r="2" s="6">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="2" cs="2" rs="2" s="5">
<O t="DSColumn">
<Attributes dsName="number_cards" columnName="new_confirmed"/>
<Condition class="com.fr.data.condition.ListCondition"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Result>
<![CDATA['+'+$$$]]></Result>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="9" r="2" s="6">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="2" cs="2" rs="2" s="7">
<O t="DSColumn">
<Attributes dsName="number_cards" columnName="new_deaths"/>
<Condition class="com.fr.data.condition.ListCondition"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Result>
<![CDATA['+'+$$$]]></Result>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="12" r="2" s="4">
<PrivilegeControl/>
</C>
<C c="0" r="3" s="4">
<PrivilegeControl/>
</C>
<C c="3" r="3" s="6">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="3" s="6">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="3" s="6">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="3" s="4">
<PrivilegeControl/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="Microsoft YaHei" style="1" size="112" foreground="-1"/>
<Background name="ColorBackground" color="-39322"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="Microsoft YaHei" style="1" size="112" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="Microsoft YaHei" style="1" size="112" foreground="-1"/>
<Background name="ColorBackground" color="-10066330"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="Microsoft YaHei" style="1" size="112"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" vertical_alignment="1" imageLayout="1">
<FRFont name="Times New Roman" style="0" size="72"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" vertical_alignment="1" imageLayout="1">
<FRFont name="Verdana" style="1" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-39322"/>
<Border/>
</Style>
<Style horizontal_alignment="0" vertical_alignment="1" imageLayout="1">
<FRFont name="Verdana" style="1" size="80" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" vertical_alignment="1" imageLayout="1">
<FRFont name="Verdana" style="1" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-10066330"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<f4BP?6=bJAGfqT^B+c$;%@lG54T_'bT+3X:'1g@4Z84AVhEDZm^`=9?9GXD/<3]AeX!KFV&
1YHBMekD;lN0C&27LR,nU2M+G9m'Dt!RQK/9XQN62+!Fo"4m5!D.bgt[8E3PY/I^N8i_56#t
GoW1:&q]AcLRS+Y@DeSi?5J&mD]A4SR0h#/)hQIm9M.KC*6`[<gpr\Rf:LQOCu#?r[\X?:k%Lb
*3qD0s]A7&bkBV+]AhePcZqb!(b.>ia^TDsuL<s8r[`E7A-I9Xei^`]AKI(<rdqV&3)M/>U23ob
T7n3_K022dPRVS755JYh!=/QJneZQEkm?D@h4hCs,Kf1AKAjRb7N)gCC'R%OLSD**PK2q?9@
UrA-b`ebNW,5oej4e;Wn!jJ=7eGVfo4,^l=b,EN_a`G+MA?4)BK0GP,M0h3/S+`;pF%8R=E`
*3i4oJnr68d#c1>i]A^8(*a(=Oumce'=1G=T@;,19Qi[NIXOlhE9tkhR\Zqo/\<4VV\""<`M^
)q-AUBMfI_&$893n2%F`HA-8prl]A]AUCSbB]AT!j*)@,tp]AfjOVfDCb_o%/j,$AE$n^s)Yd4gh
0recDJ2Y?%2]A#$KL^aB,K[(1&95;?/:1XOec<=,eQ\-UpS1.[k$P(DH$>1tF739Wo\SsZOf0
_efa9/qL=_e^^9j3*oFd.&&P9j*f$I/^mki93[075:+!!X_qSs6ed3BtEaYtlI8'poP*N,%^
@J<1Z0h'%;]A]A:N&XG`#peBk_QL<5s::);uIka_i<=G6Yt>)=1]AgK^#U%kZ:dC,Y]ARj?]As\k<
&6.TfFcFZDqXAo7<ri1E<I*$!&n"#l+<[F-LC!mnAK)1tpg\U!M+IANc+aRLSW)^XAn+LHLi
8257ZtT`M@kWJkGMj_E/Lm\,@pdTGSrn0f0KYnV57EBab,h-(m`L)]ATH1bI5;1PC\bniZQBW
.0=fM,!bT)'52DEbu(jW.3H@#L>Eb&2Y=rl("kgpl':&mu!tMBZ0>C@;b=Vo]AR=Br[U;c.hj
bXDAq[diiI)BINKJ^OF(;,Kf-a0NTa]A^$^Gi420On%40^\i<-JZj73c'0OH:$5XYFp5GMYE4
q9:EBnQW]A]AnS#5HGV+;RN\06]AZr/jX@:4P;QVthmG5Z3>`(#&MXck`u88X6sS@i?F`B:<FQM
D<PPdZ\qDjU)@NXIXX9k:&1<4<rQJp_i1U1pV_3<P@S^16R5af@;tSK>RaL9Hoo0#*riR[DH
-LaJ6V;eYQUgJuE'a3_[k=Ch;\b<brH)VqI*3J$u=G/lo_?GDfG@7PRuouW8V:O#6%TCg7+V
gO'uIfe1u5ED/8CV9#I#f@_L(tW@Xj*MSOf4!O3a!7TQd-&.5H&:r<pY>;@YR3u@Rk]AKKYtu
)>O4'Rge-N+<@?I=#"F2>AB-<Hr\j`q+Eh<aE?AMYMBq)DM3ScK\)nf1bNoY;#:jsVTcuR";
rt)J_!Uq+i.@PX,qWBiVnJZDb:>3t/A'o&IX0#4*Wm9QH:pc@2o,p`#VY33X!P:t4iEk_$jK
EEO^p4W"UM1b0D2"m.16uN/NE=/?dl!rE)5DOi?NrtjfYSKZ<8sGD-gYdXK;]A39b!NuQis\h
>`>gB"(A&7,*&SF3iZGeAd-bD!^tp=Gl#Z7".Ub!kJ-/aJJ2f,c(a,MBDPBX&\Oe5F&4R_+5
nJA9[pp17'11>,d#&!*[iBdj3H54IRkd9tLHCCFd'bsll-$&ffWZ*E$;5Z36=k2YONe$jEWN
LH5fY^2drC\%UOP#=<;l?(@9Hr8hm*'[\Ft@?AadOU!UQ,dh,aeC!'ZJSKQ!iZpCLsQT3p@R
>?\cfVjP/HO2oi=bn&4Zp<tf"o5BS1-csi/K>n^?Gar!D^(c!>[F7&LMr@NQEH0>:_)HR#YM
CVnh_r4(\b=e`eiF\9?\'CK2gZXTb]AZa'HYNZ0i^"*<I`ek'9&P-mK@E\E?4%%c/o'a,\7tj
67+gpS.oM,BelsG]A1tWi3+>_)>91ol:pBhMZ/,\cQ',_3(8O;sP&-R1M@PL]Ae:ttXM\cIMZg
nKlDGpZboea=[l-f2r7/+BMPd(rR15f3X3cjZ'g(dN^N80(#+!;IB,<:8Vr1M'8eHM:M)&DL
)7bIUc5*;*:rC.sgP&h:E<03ebs;'b12l/X-1D'm]AjWDmOtQ7t"N0ok"S\tV_(3,,$'BNR#t
l\4n8;qH[7`YZ=E+^&Y?E#6&X87J1`;b00g4W\nr^]AO1<n)iVsK2/J#=?t-ZJ0qK:1oJ1Q0d
T/^S;%+4.'V<hCpa*0aVIhIX@1^ZS+l]AcnTn#\=t"F<;^o;,Zn3O.]AuQ.O#KF/q9RA_mM>4X
0/Q^#lr+,FT%;r%<'M%?6*D*JUYhKMtOaGn+`08*?H'@RP;8rVm&`OtT)aLA>rYj3f"H*2QR
+D<Wr:KuAP@'aq1N,22S%OCf9ZJ,$84di]A:Sh0,[#?F-OE4Ji+8&6X"^o*)prWCeBgi<Um\r
&#?:N-.aOC<P;G8h^2!#pF?kY3KLS/g%JO'<3ke*f02APlF#cN^dFHZn*4Z8tRO$(uafg.on
m3GJH6@bd%[X:2OTg80=Df*f;T:KImQ%tY#oD<<b3;ZfA(>T8.fMokF=UB.kC/KC1#ukVT.c
HJ`8V:a@Ze-,WbX$4on9;3ml;L8-7+]Ah^66q!8Un@udk%PZTO`p2:jE-P,^%H5ePQFBFBSth
)J@:dTIU(J!j&nTI5P7C7:F0\Oo>k9p-FU$NJoQX:3__fqJ7_dn`;i?.*km_-[L]ASjr#\;BR
RBSP5+.3U%,Ba[TeXV&7`AT"j2KE_-&!$o'3,57#dd,)^^+nT"k7&Y'_11<dO2B//H"&h;L@
SU'F"<q=Dm*Jj$a-<PohO#MQdA'RGO\,70"&hnkU9m4k-Ci@eP+Yf%9[rb$)Lld`GpN;C)#G
Q<]A55?9nnjNFkuJ&5"l:ABWBO2o#]AL/b;DbX_e6e6[qb_&t_+]Ah&WPniRi#2^22kCC:]A1,:d
dT.>fsIeEs;kp"LCY<4@%@0"\a[V1*uKQOCPkC?Wcb*H6%d98a"M=W,9Xa15Z;]AaPq-XJmj6
+`]A#!lN^%!Z`-Uje7dqa=c\rSC2$6tAk[F^7*0"t5>h(-j)*f=jTZb5&3Lk2G6lLj>W<\(lH
YU+9JR"cQm1->j<,,4MTbPul8#"p[;W5ern-D(DceE*;d52cCi^B;,Gf,M;+LI-oLb?#W?Q>
?q[@YODD1^+0"Xj]AcA]A_8H!_<Z1MkY!sq/ZdY4MH!?Bt*?Eg`iB5V?<[Z+:1YhD(i\OeS8;L
U`-sZCAF0V$;JNh@Q16bkrEqQ.O\0qadj#O6kP2DiPmTL*u7biXI2PYVm96r,<"Z2*oN;C5%
(`47@,F0_&EJOUd^1>F%6B>`1PFY);C!U`cUMA0;6V$4P6QhjVU2W%Q1qU"Y9`"U?1SaD//p
QF:s^Oo"MCM*X0%!XfuE"_p%9n+o1@qk/lhm+\$GOl1LY3i_joiN/saNB*]AsafHaSIUhS9T_
r*3j6U<f`L6pYR"".quckdsh&%`[Z,:T*M&6PsNrLnrb75CKR1n[2<XDk,eM2Rb/W;OG9A=O
m'JIYNNLga^WBIp^TFpI%q^Woc')T:EY&ZVJE4@o431s4hjD39#r#*Qh^JcVAhf6R`.KI#Ot
]AIJ@__X)OtJhgn$(XgKWbcE:#O\Y=*P7Cs&5^eb!&Hj5JG\qL/IECQkO5B8^-n$e0%,;Z#5_
K%E*Z$6kU%XL*Bp7LQ!dFi]APhL11'Cq,Mf'Kqobr&'@N'\o9)"!SpSD@k>^B>)`[oI3SQ3/L
\SW&m=ad;'/pV\4/^TMfkS.)L9lHf8q#f%[F%`i/e1PPr8k)V0Lo4R8i.C\Z3g6CC_,Lr`Rd
NI?te&VYCgPgAf_F@F+`C1W[TUnp(S_!chHc1)8!Q?sJ+khgpgM*Gf2>S1"hBR+>LdI1)1O(
hh%(BXn%L\?I,PI<&7`O.-qoe@Te8!EC>;n[3`J'$=)Ift62]AaGoijN$oma%fc;-9UhLmXC,
WmsOsI]AVbngG'h+:9dIu&gooC:KZL+o57Vqp6'=Z7c.6]ApW>'HjZ75*C&pet''hnV*r74W61
B.\"@iN_p(tX"X=h=[UJGG`lEG^*>Ia"IQAq8O)P:94a]A"'rl277Tc+?^;<B"V<n0gcs*OF#
&]Aoaa&fU%6NRZpCU6O&@(-m6qk0SP9F7C3q\.V@[X(OZ_G'TGI*qh.N*9+`pUq.+PV*=)9Y$
_irGSbIDZm:,GC^^\;dZG!$iX"[U=B$B9PhT]AbUFIul%#*f`p&Nl+Z>`Yu%7)UL/K\928P\m
d]A)7J?56K'38WoT@NJFrMJE,Hi6cTG$r)/..0'0jfZ^nL#fdWr8aV5+nR2GYVVk#bUj^W\V4
!L<YJTkVp!7ckLiQW4,-bA0\BM2$?0EQcqXHnI5,,La5Gf4_Bek18@HPP?TC`S=c.q20J&/m
s,h0oG)_CV6f=LMAhM,DmWbV]Ap8,S+a87V-)C#qAlirrdcpI[6Z]A37bF*&i=OR`'I>$Ab/r?
(<H4g?8VW0un0fUoN8^Ct4CHFO:MQt"/?DsYB<94PC!t:G_AaeoT?J4%>AemjDSB9oa&@<m5
Ip2\H%8DlO-h9*(3L%]A4r]A"a.=^.(h<4`\^@Jp4-#Lmi$p0d\$d0I(*Jg]Ae_g-&ebP0D?*a9
4\`WC.]AR0cHh@a[Vaa76(B^n]ArmYP_"@$5$2EGM6KK2ieZD6E#*8Jq`lB+)\GGj^RqJ@F2qO
*`2VtNd!.Q=^KhirM]AaYVU8&Ycb&$6*FcR(8?YPI+1Wjr`:T;?rUo%B2nE,^aQC<!2N3M%B2
j,Jql*t2ao*Z0A(*)+/IVGq^?ub9]ATMs"<Q*r[JDi0CTq"'1?ec8rC>uAm$PM&\)WR1fp!1%
d6fPl^N*V')m&Z<"i-8c]AM_`JlTNE'Y&H75u@^2,i,EBnt1)6.irZ>gqeCGnRQS0"ji$BI!G
ReKgeb/siXQK&L3A3_9??D748,%;<[g\4__0NPNI75ui@es(*./kR53HdTnl&:,"Nq\!Q:4%
bO5!pf#JBR&,1K!'HAFkI?iqHBP@%PhC:uDK.+#)cJM$eAfGk4Vd%<nQT)&;X5%Qrh/K;3(`
Yk!_+`iG$O"0l0)"Vr4q5dLq'oRNebg;.pqF^hGb"\A_#R.^/I!t0C.c#FFB-kh30(:lkJ,?
[e3=`hI9D&r$Zg_+("*Li.)3OdVhl:WELIM^XH-Nu[!e(9WcVZ$0oV*;c;hi7BW+)bJYqLgK
5VMJ_[DWn+g,l""B19b/nlJS[HM_G2N14b=F/(0OdX;.3r%K5$J,2:NOWT`d?+%d-E+l)!FG
/J+ilfK!oLU5'8&tneOM(\O#*,n7G?,qb2WSiShg#oQA*86K`1`8_5g1_]AN+PZ\,)M\M8JAG
JU9@$/.]Ah-m$g"8l^]AKdLY*]A]A]AA8iXsW:jQJ!M9;1+K(IHWU8S5t2"^TS`#(Wg_OoW<!WmOr
1u6_,Uc;8[!u/?,4;p&OR[K>B$8g[k3f]AtQ$mee$!e;-*KIHmDX2GU"23+]Aa!MgE"Mn+NRbK
1/#&RlHPJPRNf7V<Y[HhQ[L)C@CqSHAuJhIOEt.%m-N!5%ka'GIk,R0JSr:F;rf()Ms(5Y46
Ze1+a#a;*#err_/%1mnF3c6WHBhN7[CqEirOf(c5;HPZB*(O]A`Yj;M]Aa'QSLR<sEpaD+l1QK
UU@dZ]A$<B-RnB%KCY3VH77oLJ4V9M7F($G%i^6\?<:;GenkO]AAmBjrP>Floh.%es*E;l^HUc
Pa@Mr4D@U37g;gHK*l#D_=L2Vb[bd(Gb5L5ZqK5Z@-QJUk=@p\CUH7E-6)*1TtQ46q[2K,@>
?Vo)U77Z^7Qj]AESPAENcMtYG&mCcFSe&*X%Ad\aO7['ZIL`a<?1%>W+a:iD5Ta:.-?rOd0mn
X8t\IF6k+Bb?)Y]A.5HIE\bo#XY>lIf1k01grQ?JP>hp),gA?7_d;(6%n>^O8RBtJ+Hi!"jUu
`P^4R/Jh-s/#$D,8*<E/kb'g*'0BFA")SY(*i`!ssRIj4#J4h&L2YPek_!nJJ<a12_S>SE<A
S3KEE(BB"]A<(`J,F8"7k2p3mhb.'Na6T3`\inR3j/;^HU_FripJ33K>l.G$p%p5Mc7B7:E-W
1X\0#U4BH60mOR961R66a\_6%JT_`,8HR$buTrRiggpL9(jJeei<*[8\[7^bhY9i^2eL9$ks
>?R11ogqAkl1S"H#*bk']ATC_+=W[DUn#HaDYQ,^eUlo=ik!X(r5jV%jNm&&U>/c^7@+%)_R>
j58OmeX"S0Bbi,J83T3Ll@==U\p199mSdPRK<]A7YtWM;'i&rR.V?jljAfU+m!7qib[!\$@3r
[]ApgU%S+!MMA5qJ<WJcp!pSY7T,i/&YX\WNUWbV\?2C9nd:Vj&8/H^XfX:SacV@A!&XmZLV[
VZ`9?=CVMg9CD#;Te4\onM9b7tW#^H]A3GM@B"`qUuAB@fRP'jIAsHO"o<?+iMPid3fgYK(%D
A:<#I&_C&Yd45@.*5kFb'37[\<VSO/.oGPP00Y0a*pk^:f2P(Nm>I"9um[L$aTQLo'?4EdX^
`s&J%Y[5r0XCp017p8Z97&[^\/%_`eIl9g(W+\QMK+W7kbJRlf=-;QQb=:MY7e/<e\b7/dr_
:G5>;^Mn[QVfOZe:gr>02o)Lg^t?USj#N@JhX#AJVdn+dMmEc2-k)_3NT.NJB(YQ5f`DOJ*=
8C+r'EdWE]AVrSahL70N/(c74fZVGl,+)Yq+Ne!!?4J71Iemj++V,9R:5#:pO)r1<ZSL7"Re6
NZTWjGo<Il`P/GlST+_2:K(3JY_Bd)]Aqh#n&(G+3eQ!3k['q*]AlMhP`)b+V9kWPk]AYmQ.gGf
Vhn5ru(r"aY?o_!uS+F:99.N[>(/K$Y&Tf@Wb9"b-.l7!u\D1aNe9be<rR:tE""B@RS;q.G]A
s*t@U_W3\kpHdEEUjGHm*/rbB\*:e+<unVXnG(21cgonV/cGlS$`.fd;G6>=S;.E^K'Z=':p
afNJQ/4Hk(1mFqLq`<M-a`K=i'l2PI"l\,ZaM78-.L22[;?9Fp3UJZ)qiHF?AU/U&Joh.ip/
l:@YXTfNi(Zmjda)l1[D^=8tP7KZ?8Qo,p%MCq$kf[IUb@X*#Y2<8ZAU_-rLkhh3m"53t=OA
\fbs1EV!SUAE=Q.3RS.IuPp$I$Dlf?RY6_^0+`[*rk3_Gk_Aa3@-"Ok`IpP*W!7S&#g.U:ZZ
Q>EXLd08b!9r;1Ah)d9(#d',k2qZ_Q3X0S?NX:n5^5AX3X:V:;a"!L,gp$Qgh6?g9Sof^d2Q
1Cq^D(`jtS_E]A]AG3OM):a2?9#$>_jtNDl8%J5i946PYe;dhTjH#7oH^Z;YK1K<Z4K&USOBYB
7N:J*d1%(\;$f7^M214:2f^K$dBZ!LY:)fL+WkUG,)ePY1o&Vc#us8n^qf4Ni#U`GS[cJSgE
UClb2f#YsqVS&7.W#46f:<nK)sq["G@/C;g261R8fg%$-UA6"Y%.p[s*1EF]Ak,,hCrFMo5KM
VVV!M'5JE1M1k)3f&Dm[)7*RmQGC.*#'m1C.s.f/eYF%Oqaq>1IE(RNQ7e_,M@04JH*#DC!C
_kj9b]A5?`C]AqDZe1!k%4^KT$(#hL6la%!drMQn<"+;,<'7%c%I,N'UL[n<Ni'V&HqNNKe)L(
]AYM+f\GRob(6E>Y?Lt.lfOapE)_DHY3el;5H(B5eV2RuMbR[fZa+Y+U?lCqO:o=lBhbcoI9`
D.(',#"1PgZ$d[)%Q]A)Y[8Fn<[sdHp9A/gFcaj9>Lo/HlNG8FE2\/F^BhO3-;pk@O#NV$8lU
.:cL4<I)AXJE=j\-+r7%J6Y09&0P!6:Fp`6eI%[[MW1Ip:9!e29OXpD9_/I;a-:^H):cXhkk
^.O*]A]AAPZmH'#J.UHS)"Gfk'jg;s4FPI=IdQ&aaJ'h$P"S(iS3KlMF%5AQ=pdd[D6RjklCE=
Gf<$"VDl^'*.,4E*4(dTJ+):4(\`43^@orI?pm*f&f^$18%[0+GOo)m5R+T$RAL-$\FPq35A
"Q(W'Eckar`P-Ee6GBFb/=k,=Nh0d^No1k;iH\V>`Kl^GcY*da@-h+PfXERBNu[[.S%<g5;>
7':"KA@\HX#h91%oHZci%->:mOW67n0"=VS:&;!$3;EDr*9"CAJ@(58YIf+Wuo"B<lt)0Hmu
7@"'7pD)a^q`nhC6KZ0,;2/0bY4)EWJisIq4KDa?%6Q`<ZHlD./XRe^E7@83X8iVZ_0M`b33
%'kSH%u;7?5sju*LVZqk$)Y?b71`L7j[C1$@h(,B+iQtb2M8CqdORF(eK9uZejkEg0.T,]ALS
hD-m&_AT8P&iRH?t5TN(.q<"Rs*OpFcj]A67Ol#F61r0iXjo@f>Th3d]A_l=8Gj%8IG')@+Y'^
:lNua41EU>bpVSlEQtJ'II%%=$8q"t+.A'He(SS>iE>X4MT%9$T]At&#m6Zf8_a_cH^j*TZF*
&I7<b4>ba@=[[K^5VAEWZ-Kl*Lq6,Tc49(PAF6K#137q,A\Tig+G"X(J#?JOYIG$bZ="Du(@
j`N:HL:+/qJOScrC2#bn<o'(Qoipd3ueo#2IQP-EL-q5sf,neFE4MN2ho(lrc[K&C189amFi
T**34cNo05JOPMnO9qlh]A6;/kSI=`FcEQ$#>h!V,GlOEKDnd7l^KKZdDu@r&W"du;^n<`C80
>N#2>$,6QICR8YN"D1[oce>JPqZ$%l$fNhg'-J*cTb*bPYJ@9OS5*QNN`.fESShPX882gEDV
=87U3,l0jFK<7><,c;6_PQk-WT'#XjTs$$B.<0Vol1JiIk4)08e$qmM"5'VR_E@M#0b60N;!
1FY"ZFMcS>LkR%16,#=*>dWNqtq\J!^7Z97SRd&cUXs[0!FQF<3Cda[;+TV*L1RKf!&'P^V$
SE2D6F^a5bj)S1V`2p]A!Hs!AA>daK#XD?$d=]AW=s=V=%HV?`417W;PO2i!Y"FHSYiul*@#Q_
35D;q2]A8=,95:kWK+Q(^@N]A!GoYQ99lI'\:Dst07qSjaq2lqdmi`\tkgo9LN4=2B>U^SlgO4
Q#c!F,2cOPu4DpLEh@ba_ql$$`t++,p)6l^)o8JO'Jo*@0=W-&t>otffM3Z+Qk><AJaABkMZ
8L=>umgWHXfi'md1,<r]A12:SB\okhZL&]AgQW1c-*q=rYN;TYq6k=!.kOE"3?5PQMFIMXeo3<
""H60ij9&CNZZPU]Af$1?tj<h*E,"TA&dgqm"U+k:mfBR^3);V29K)gZ^TekG(-[n*>2oDOC:
Z$Kn//nb6>934o(e:StlXF"n/&6joX.mT]AjOIeO/DKrql?T2GJ0N]Alok'1CWYB`?+\"#PRQH
_F?uIq$R+%-Iag@ir:qGMt0PJg(c-BU0Ss4INW>/SbK5c0NO]A(ES#pHDaOsW@2p1Y2YADYR:
,d40<p&i5ZG9k;%L/N]AnfA>s(4=E]A\,t$P;t(p%08RMVH2<r4,b9%1B:^%1(p=]A#To1Ou2an
7</"Ga7b#hSSKdfiPJJ@lD&6.J/a(>S$]AA;o!(p?0BogS2-H\a<nmZLX_o3Ue^8\Pi;Vj+pR
e[DrfLj:juP#>?7h/Lr\q"ZDL`\k%.qo=O4#Ym_kTA+;[;P_N'JM>mP6le4s<_DJmIQm;g/+
V8t2#M$,Q&.K$Vkha!R5O#+p$*(HaDoQh"aYo;OQH]A;Q/36`gH1E_g80le:h@FrK:X3@rI.r
Ocpc`/1.,hG9R4EAK,mafMdG1o5ESTGs&7U\&.9qbChMK$5NY`2l-+ed*KsIO>DN4AJn8c7`
luGu<qGGD%5GYT$b<)jER9p%O[6DReYV/,Qs*D=#T>.Wgj$.]Ahhm-;uj$oGK221:!DoZLV,.
0.i0+6#O*p+'"tSP3!u.p+b0qmquQZ!_).+;:.jIVa%`3,XY^tV)b`i:>I&NSau9,a!'c@(m
X@XWcUE.s"3(drF_+o,qYq0l/Hb8X&AjW#XagIQ3bAIdBNc,B"1."L*`s]A4r$'PS)R$6gAPf
o;#+T]A*Qqm/-KdhjMHl7:*$,iJJiR_YVRJb&k77<\i_qd^W8$1r9*-OWG^%S^[kIb!qZ%kEg
mX5nj=YGWnMK(4o(eJF@JtZkeffDgX>SBXJh)42LUg4k]AmE=;GKJ+srk)k%7&m$+Ak[?BQjo
k,q@>]A*i-pUEZ-a,GasNWt9*e$qa#H!j0\c?46"uXXr+'-KGIu8aOhGu9!36^_;rJX!";N"9
loHZF#TfBUe[[IIQkraj#"'""%uPhD_jreo9pZB;m`9Gqj=jo_jPS?&[2WiOn*eg;V)VCBI2
Zr3rZ+OSmF2r7rBQNMZ*31.&'\esg3Xe5Kc=\H$-IJT.'Cl-Iqc#(Hrc[=3s9r;jg!ahN;to
;%RdR14^Ygujj!sjH#o3&O$oQtGe[O:7i!Q%.E-@5@m_u>:ic*O>cp84a:5.*53)(M70j\F<
oM@#F[F`n`]AsB]A`23($JoEUOjlt^6.XgAlm9J8"qSY4o)Z[`Z%4iqmiar<NjHmbAf)-uUerr
AIVu@/oc[\e;K>BeS[a)f,fCY.q>(p`4G('V7NFT@ARmZ^J![^SJb[69KVqH*'Z;ss(p;"^+
=ViTUMOas=>:p;Ih+C[QaRYG5dj@2^'HIcYal)5@S\O5u&3'?[7<gi_T5Nk#Nr8WIQTddu=&
b9<&.aP_\]AM`KG_@8[T3Ic5prlD#-r&L#GIH/s:@>^d$+S3YVT@lkVAKHb6iWBus*NgbPj0j
6^+&JlB\'BKIGVh1TAungS3*!*H<p,[\,DoZ.\p#*=l'_"E?ERMQqs5f<kCPk=\gLZhdDPVD
VPWA6@s7_T2P,fkE3B#b!fiT[2X[FQaMbaR$GlWc-smX:"1WCpe-IJ8DdbrZ?UU.'cmsSn+*
8i'g,*N%'t-*fO)7SOe9bmWZaN9Ek1Y#AQd&bSk>>nbm*Y1RS]A2XTc:`44:iejG^@C'\@KgE
oqZM-RI,t`G5rWrbQuGdjf;0!3$.,"6,H0_8"T!_jeg(=Oq<l>0bg.=38b.m+i3Eu2TUNJj0
&#j88qGc\F\J&Xu_-8GhgBj6?f;[7kmd05W:Tk1:j>\F8>&D`FC7b7+0m=dfLQ&(jGDKdWWV
WNH0g]A,cNk$%d4f+?&NC!4$rZ_:V(3V('_<hopZg4O.)$SH+"+:0G+Ao.JK-IJK)'^?&)Uo.
/0n;;#.Au$.>>HDTl;,:d9Asm5H9T6n>7XN?bQbrAVnPG2b(iXLqO,Ge,eFl8S)n%[PB[(\'
K6g2640(f:%9r2'ukkgmjo,-Jr]AgHf'WodZJ8j_/UC8h@'V"=M/nEQu:Kj3H"A54&RsGLG#&
O"i,If/jo+3Q1\FTd7?#9YkLeI:ZIgr991,5Xc9Pm;Xc,NOu]A?$F\%c'I:N+5(s':G0SUJd9
pu<et8V]Ab'/cJQPCg-6:KDc<TNAqnrf@?\Eeo87XZar0WcpE\;Dt1RAYK0pr29B\BB.r'$5k
&KkttC8([->(Y^+Erj&@EhAmVWqN+LL^m,aBO36@?EN%[i"qs:F7$%c1mHTUIa!#-D#Mc"^k
NR9"4/_7IZdpKQ4#bGmJ*'K:l?Ok)m.PuY50DCl]AorD'76J9&rr:2NOHPrOpgs!K2&hi10WX
>*]AKkbPh7^8[3t@1]ANq:!2M5n7g+hi#!^2%#Rh\ipIgq'RG(g8N5q',,@LSTpnN*bm$K2l/D
O#+PX'T0`i4cmp2Tqi=oe;O0qQd(PaZ]A]ANqNHaA:PTml/ERn\iVZNN"-'3t+c50p(G`ej&JD
X(skUd#CoQ9*Z@M,AT[9>$5-&2>c4n[feT0pf)(,F5ja/H3KI:`8Ad)%N.OE7^38"``)(ZiD
V5/I(Y,+i[J@#mdlKNp*YoZi$o0Pa1i3>Z:M\8m-rWt:C.!HX>E]AdLJXe!#S]A2oaN5:@Z>A(
I`ns/t>=uW<Wf9qJlY7J*H\]A!`-,#1ec%db6sIAJ&0H\/K@na5%6D*=?D67s/q2:&#Fj8:t`
mbTM7qG>e(R^K?p-E1,oS\EpqM9Pb4.6rA?X,gMU)qA0C@RYk%'LUYe>_GDps<125;[H41to
+;..!b(Lr%rAR26M'oV%4"mBrPehOW;#U3&<pRMgU46BKMomoooQeSL%TKBb9!FH<]A+>\5KH
'g&73'G]AGdV=e>i\"&T:?3iFA#jc>Wq2MAZO#A5YDk@Ig724L1)F$&%n`0a;*K_AqdBa$7!b
Aoe<9Xb(&#2p%1k]Ab.uMLcq28_64U3q8fg\7PCf^S7UOc`!hT:I?PLKRd<(lDFG253-;JKWY
B_tYW]A$0i8KN0r^s93pXtnWMAE,,,LXP7XCa>[>)(OGZfBX6,$,bCHqcm4)VhFse&Md4UJfH
DQ"pJ\f8!'r`bFPSU^1dC4*A&F+#h>6$W\tNeQHj>f/I'!Th!f'VYBi&!&5H:hE^]A<e8d\bf
=su?F`U0B*ckKCrl*=JX.$idQ-X`?L]A@ugq$O$VDAZhRkL4+j)p"2dQ3Ne9p@8T,MpQUX:Di
sQU80."@1!m\&7h7H&Wgqr98CF;.G;[6/^Ar")Abi*fi]A,fE#rSAEit^_oX)d#(=Q;$-9:n!
/D]Asu5`U;sK::p'a"W]AGN;NK;60#t"H*k&5OG.,T0\cF3jF`S&:;>fW_\a.mTanX48M>FPRo
m>I/Mgkk3*#Od5ZtP,NrDpKV?H4Rcl)cR2Qg7n*1*\b@]A>5c4N"CCo.gfiPs!:8ak"#6<LpO
cVokU`0]A-]ARHH3+o(6<id3lK<'=PoCDqI[<kdi3K08U3OCBMa6@4h>GgUoh[9*l=AlLD6D/F
^hN1VT1Zi`(6*3cS\ppKD(`ZC1&OBt%XRSaI=/nOHut^6dm:U/e)GC1Z&P_0^?i.S5oP.4mp
Ump3[pA(_/FHh33mnhXMYFo@?LH7lA\^Y.fWcfs*<I5;$t]A8\ImN0lDgT%2;ihK4K@`8"e>C
;jCBko/EYRTA(C3DCB[W$TsqRo9iHLhA;Wgc*!%MH$&XM?I`-s>JsT<T![.`846fQk!N!6pp
1($n:M,8VeUjVo*(Sacg3[LX7@PKOmf=0uF4dJ4lMf7f5o=+h]A%TrG(<hIuJ)4?B]A=RFTc(F
nu~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="360" y="44" width="739" height="106"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report1"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="report1" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report1"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[723900,723900,0,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="5" rs="2" s="0">
<O t="DSColumn">
<Attributes dsName="effected_number" columnName="number"/>
<Condition class="com.fr.data.condition.ListCondition"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Result>
<![CDATA[$$$ + " countries and regions affected!"]]></Result>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="0" r="2">
<O t="DSColumn">
<Attributes dsName="pie_chart" columnName="country_full_name"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[Conditional Formatting1]]></Name>
<Condition class="com.fr.data.condition.ListCondition"/>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ColWidthHighlightAction"/>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="1" r="2">
<O t="DSColumn">
<Attributes dsName="pie_chart" columnName="confirmedCount"/>
<Condition class="com.fr.data.condition.ListCondition"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Result>
<![CDATA[ln($$$)]]></Result>
<Parameters/>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[Conditional Formatting1]]></Name>
<Condition class="com.fr.data.condition.ListCondition"/>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ColWidthHighlightAction"/>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="2" r="2">
<O t="DSColumn">
<Attributes dsName="pie_chart" columnName="confirmed"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[Conditional Formatting1]]></Name>
<Condition class="com.fr.data.condition.ListCondition"/>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ColWidthHighlightAction"/>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style horizontal_alignment="0" vertical_alignment="3" imageLayout="1">
<FRFont name="Microsoft YaHei" style="0" size="80" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G'9P?5?)\$NKk&")5,*OJ)kh9NIBQ^-34Q&h#Cf<)=1_R<ZG6/J8n7RTKK6:(sgf!X9K8G
Yb".S6b=lm`i$64a3db*>p."@7hT0e9FN5_,4)P.^V'DmZs\K:I#'aO45^LGOM!3Tk\Eht)2
DcZ@Ct#Chc14oN=*:FoYSjQY8Tr9<Sp97B<5ZK0n(++F_!8QX&IYtLCYm<JS*YJ.n:2DOi=7
`s:,_X18<Mp7;S5=db57*&[0m=3UarJQraU/T`,[QIUbN4UX\=LeJ.Q1AB-i?.AD^]A3'(&$.
-g3f*6`:7LU9ej6c4jsE!ii_3^VM&;Nt06<.Mh@tAYf3:,`4.U+nIHRXd]AHY=oQFRDc8!s0Y
bZbb9pWKT3'YAE>1%a=bGQ7.]A\YA\2I)MtoK<jn-e(si2S0p;m-4sTe=3bN-6T!PjYTVBJU\
H)^P[TT#jg/bSY*T`\A?5guI\4!C,.=Mo'3;?0bfp#baj0jlbe@qAH@d[&A@FSF[4#NWj))]A
d-IJ^UDVZ6UERLH4QkKlY[e#*V,)e<[k:#OeWEcWsb&2HnY7qK1HFT\o]A4%@maut%G$/pt`D
kDp(:eoQ/dWBU?CIGAoS$KkG3DucFl8Hdh*NCM3M&Z@lHt8<pP#0u:*>H,!PB@30^@)kN>6:
&=f%hi.mgYoAjJ_L7(uPOZA=7#T'5Oc7p=A73S'MgH\Fg0#nq0JJHr^+%9Bf`lKkL;LjLS5g
>P?kJ4n??CXB>^$pj@qkb5WB;T<,XMFBpTl8I82$*4FgI`b/g@lk+)LMJcJC:9DNZ=&Km5?H
LM.nY>-nZ7Q_(7S#//*KVfH*c$fr\ee^$FJcZ"E7A\0dY4-pm%G7l1TG=/#<`_BofTdQO(p%
&nUi2LnRLEi/JBBQ\);;DbsVNC=ZF@HY$mj+Cop[s^,m;*.6i8D]A-.3!l.3tWdfX`Q@l8l`H
OleT;!h#L5S-4QdP4nd8s)<oXpI!WSaDJSY<7%Ns3hk*/opR&4WNEWZCGqb-h4_;Osg%-]A::
ni\QQJ2'H4aLllSY8'>OMA>%=jtFB5OmN70i)A.;Q$XjNoPl!ONY4FLNPQ[$El-rY9X"9Et4
c`!'B6M6W:UA]Ao^<u>Kdps+(5h8>UBT]AS+B6\0E2,HX$`B'0$@CONiS7CX]AM:8W6S7h?$_!d
)nRBSTaB'.'*m.^8NeG]A@gMef/OK@cLGQ_9>0t^-?GM.cQ[1jpHDfUU+QOeqJ]At7jo:t4]A]Ao
c>"s44cH\2Kb>^bQ;Kb?)7[]Amak"IqWESDCjLNil,Lr?m4ZL\At]AY6:T.&,_Y;L^Irc9BCMe
a-P8>[^1)]ALWEuM+F_Y>j&&W-EZr%WNP\\_+eONd"Q%lV);16)-S$.+dT5H5NKcOBh0Ah2p)
k*GtW.=O#OheGr5Ee]AlbAsr"s2"=XYGsjF@2#VKWI#rPj;F1D=d%4WKGZVm)5F=h+.7').Q.
81ns18]AEo/6kMrlKBj";&BQn5K)^F":[n2n7t;f?DP'h9cPcBbDi=Ji"H8E[ef"P3eFYQ^o9
)oDlcOWC,W:m4Y/fAA`AWL*,r.VY*OW66p8:_!X"8WaWJbrH06MG;b>hj?GL"IQBoLrUV,!.
CmqMHn4;JR]A8Il2MZoEj_9URJtFqkh>8qRT38E>dUjXt`[EkVE8@m5rCK`7Ue//-e@CVq.i8
GkK;LVK@=RnM?&"BE,ONBJ9qRGMAlq[>"7$$7Q%@b4=Gl-]A'QCck*9!WltVh<u@i$APIgWP#
l"La9^\Z;8S$L4qMF$gORJ]A79fQn(0IF7ieM>N2B-Dk^@]A'F]AdJ!3W'RZlKjlTIt0,Da&+Fs
)e8C@]A681*&I>,CnCjtSX%6t`I2@GS.BcmdYRS17ja4Z3oW.)`EQ*DX^\o$(*6uI25L@I!C%
ppa-au7/omn`'N\Xb"(%0WI7!19@rDtI_jpUCh+oLij8:]A=>m``I/gp%@_K6Z6+$F,BFf"5/
L(dt#>"KX3T[Wde+gAT+$e[#jCnQ&m;eYMU?#)p_DN<AVhG8Soo?-uq;fCiLLk]AKqk/rOk4o
klH^GO=*H7pLgr&L&)AB&$2CiD3gs.8X%,d?0Rg7#HTS`=S=eF]A.X;;0\#+[7,K:HNNH+Y9L
NG^'AABdYjaEWJM\$R;lSu`[]Ae;D&mJ;Ijg=B$MhjA$Ha$%ZWm#G1p3+fRN[+]AYqr>%/>pB!
i]Al$gG94]A5E1t$s-]Af'ok.FQMMGI3G>/P?q#+;7(2Il:p'4[()(8#=N0;QNV,&Y7;U[E.cII
\sVD"$-`0l3iQdE@%pGTpEXVl="`SQe;@L/rBL\'#L6R,MsIpe:.Og0JdrktWhi"1,<(=WB=
_<EGEjlgAD]A6821FK/#0C8;aJ5'sKnQl3.Xi%jl;R!tU$'>`_)hV;9jL";CjlOuStP\O+*A2
WMDX!'#>+:Jbm&\IM%!"OoD]Aj,MmfQi/9c(W[+UKkf?ujC;O]A34\h*4p\%_Sp8Ls0886\R(I
`$ZZ"&=.H9ASFj+??*)'&eS1O5U1A3F>Z$CF8GBb3FjMkpG"0Ib;PYhuH:t05<rQh6Gq]Ao9k
7%W^Dl`"N=<fkpbZEqUo/YIO0E*/Aj-*`ct(5Dk)Z+I0F(/bdL)GN5SS9$M&0R75h7Zi;=N9
?HFcP.hF^hNruk\gqeYM:i1.$l!.A-f<""BHc#$m^%qBFj4RLnREpM2&Y0[M:uG`r+5(/4l@
G#aof&lhKE`2:!)d_arMA?:er$jo#;*MaIMc0s?NOZmpC9nf;oW*51r6!k'e=0H1mA/n4H[$
)>5`S66m1a#u5M%\lT*/2*b065Bt1ULu=aW?4H?R7/.^HQCl-eZj3l^KJdk((GG),BfY=(=!
g[b^sO_Y]AVWoK*Cq`?t+OP5E)_[=9;*t5M-9@KfX(@d2+9C*\G%RRdK[4s%'Ur$Rm)i;%R0;
^sd5:q?jb3\lQ&!9RNEnq)P&l!40n$''qf^9@hOX.uQ#0*F85:"]A/Hj3&JCheh-IZ08O7$3c
25tkF3[><f:!VbpEWk0Mi@=W@bjmU*an]APu98dES&2Dd"5Y_X@@$YVH9Cf:A'D`#GU=q:4bM
#ihNToG-15f[5)rcNp^RkK6uQ[k!R.[/5skfk'/Rg#MH^'lp<!#4;,Yt2Ihf(L"4E]AmhZ.k>
\B%bF[1HC2km$G$r]A&TVtC[Y(A(QIir8U[e`L),1PJnI=1J*Q5(+8Q[rhn^S)6!#::l05J@@
t0\?7/XX6^%a4^[K]AV;\fu&2RCIVEm6Z6GjKL8@$&M(hQf@SPsQl:ZQ63;,W7je\=n_&:kOF
USC.@^#5)4hu%'T?A2_QLl%i1rLbj]A$k#W.2*,V^="pW;POU?$3(]AQ[=K;6Sp)>uB!E"-s/n
YC2MBLgp9JX,P7Iuh.WV/j85pUmo:f]ADiTcTNs:LG`HRa\LF^FW"<LEM^Z>WntD:(gqG]AY,5
sfs4SnLEO0b$:o"O50_#J<eu,se$)rs7sYs_M4l0j*NioSoo)YTfTc/D2'o85cC)r%ARH-U9
+T+&GU!hE!*cU-UI^e*g[BNaL5jO$'l8ANc_Ru5j#1bb:JPW-'r7"L02N+VS=g%$0iZ\PE3Z
59"dO1qY)RH*YUkC2KF1RBbb$T4BFQP8B<S*D??DH"*1p@'Wo1e6>7J<]AeR7!Eo%j!:jrtZ)
>t,0MJJ9)i#sgE&%FQ5q1O=L$0qP&0OW."gOA]A9&(Kd4p#W6+m7CCN>f/#0c=7o5CVj\rfAI
tR(.5M_k?@_ZfPQ(7Z8<IHhlBl$tdP=td#.M;&IWZqR#>CVu4da/6q-]A]Ak_'CMh"ai(T;!91
H'cX.&\l5'1&/b>!,*<gPmK4Oo?+doT-73_fap'BlRPo-N\Yq2b)0]Ajn&,S7BhU]AToaWA>[-
pTGP7E-$&ldKO<#)N-A7V8;E[p*%uP@R;2O\R\DG9O1Y4^Fe&Do7j!#hY-a=-XDXlqep[-)*
9bmgK[3=l;_j!lkV@\&ckOG!>[Bl%1t<C`h-O9QDU5LqN:#5'c`h^JH56P["gD*R(9^Os'T7
3SU+b.knYO4@K=,BCVa^W7L/O30W`+pP>"7g?f-dI-2@jKLV?7VkVaoM.W-&;cUuj6.nDQC,
\(UC(hai7u-qbr\kWJr@a(Cl#b1S]A*!e7ceF3$YOWf^/#p*EcNb@Y0uQ^4T!Lo`@0g*:5I,o
'BY1q07eU[<q<73)1ZEB,$#r$WUM3`erf<l(0^!Ao>EVl:j__Ii%H<0oI%&.qUMA(AJ:K$"?
]AFC)jg,Ddo[N'+rHleG[sn;0/"YkKIoQ<q^?;X*OptVZT=D6bmFq^jD=nA6!M7]A2^(kb231-
&jG5d8Q-F<Drf,mmr@/GFoSV75u7cMN6HKja9Kar4#3C,s64"fuS(`DD;2qC8Pns4k&E!MbB
MSZYA$6nZeQ54@h]A/#4^&#Y2c?SFCrma"^6dNre?H%lcODQUX03OoQfOjO$K<%o]AS_kTmV!<
e_'n-(Z6bCqmj)WWlXc!20^@Bh3lD`t?_>K<*B,@tZG-!\IoLg*BT22F3n&V<nLXb40Lg4:k
f"%QtV<:*:+m6+6qKg8tV`SrdbJm?m?9tgcFF:RHDFL@o?cNicr'\+@:J*f1N#3)puS#TbA:
qOA2nK^(s`'tthbJtrshDcQ"C0E\R+up`)f%=gr%7Z$SPN_=_5%nEj=,\l=B7WaY\e)D9&nu
b9j=./"S&3'`Ig]AB^Hj(9-F:b>%SgVIn5YnM*aE@,@m>]A"J&2d+iOJ6V"eMa4=EqKVd>mA\$
Bg,h(idJK>$bX+S5-J2]Ap<;G2M%SJRVD$AuQ_aq[U4gncZJ1O/jp@8"JH&i(Wgtec#=;Z\nI
4-Co6_"U"K)Q,\u2qIi[o2]A\F]As'[f]At=$gS1.q&9="^Y;$E2hfNMfUNnManORVg/bLeCq.W
M?>Gp-:N7]AnE%sB#ZjMZD;!=oFe.B#c)_j$B>-QE[XFL]AH<jQKE=R[UgbB.SueoN,kOXVoKp
jL!mLd?1"ebr(i.:8e&1m#1fM'VV%5>8XmUumG'c%\'U#tf.F^1u)/c4!$E>RGLYD8ZH/p>F
mFNgGaVE#:lk@pW(.O\Y(X$&=YS9oZ_!0J`O4I^m[1&-*=.'VqAP`\6!,KP7b-ERUJ*@;`"p
TUKY7VL^/TV@)`S?<f_rf?>&0)`[*unIU@'`[h"pV&.+V^,2dhc7(0eI$G56hn3mTef3mqU]A
jPH/G;fSN<ArKHD&:\MT&hHJB-3?&BQTf_dkYf_JKB/ID(?!]A!#J=;ER+9pDt^Y6FHU0#!=&
$dN&dRSrpKi[)L3Z</fQTdI<13gucQ*1,itBPh%3^]A787LN_\o6JahnCI`NEDQ`;kR>Ap,@6
"QKIbe*s4f@+u"(NKB!`%db<%&5=?92pA4d(-&R(-!#orrA1jTg0Sk1180m%7FR5=2SM'Pim
fggod5WZ>T*M+PLj9DS4s2:O&.gjg7'8\ZL2,TEQmrcsr5u_XCn#CsQ$K#D&k;a[m:`-;Brs
I>_h@<M`aV]ABY-pAnsP/ZhZ_)EWn?Ga\R[OT(1k/Q25pK'Bjh:"c_?XDd$.(GmHh=H71u:$Z
RU%gt$;I)=eEqjOepK6Gjc$Mll)re680CrsDE?'))YFb_p>V5S*02Vk"38&9]AU3.\4sPW9l\
0HcYmXV'?ODoU)IJ+emgMO'3-7-T]AGBLU\p:%214K%:7`(73Q3^P@t?oaZO9g+)'^EI]A98eO
e!R$43q"t@[I7[,h7T*q0-:NoXfU:[R7F`!bcV.WX"K#ZMe8X<;1XfFnQX#'k#2Y66!+?LOI
$oEN]A-h\\\bP#O6"SB<oqoOgu6S(_<O"OkAZB*"8XuUh,t1+o7TB#ZY&imYopFb\EA/B^@7J
2O!p.0X&%`-S5u:^W:P6^``?d*1+,>PE]A'2#^Fo!>-DN>\"YlSeO6P0?o2iQE+eRt/WBpR94
R;9(^QT$P#))Yn%3k#Hu^c'cIqWUN*8f3L,hpaI[5aW+r!61qDtX1gL-:ZYS#DtK=Ue\DiYC
2*uuV2,OAN3)S_q+n=%a(mh7*BEH0q\0"CndT"U;^dfMnkrTMc^-p^f*jWdFfcg.dRros%sP
Mc7%~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="915" y="0" width="284" height="89"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report1"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList/>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList/>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="1099" y="44" width="340" height="92"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report2"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="report2" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report2"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="4" rs="2" s="0">
<O t="DSColumn">
<Attributes dsName="update_time" columnName="update_date"/>
<Condition class="com.fr.data.condition.ListCondition"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Result>
<![CDATA["updated at: " + $$$]]></Result>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="0" r="2">
<O t="DSColumn">
<Attributes dsName="bar_charts" columnName="confirmedCount"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[Conditional Formatting1]]></Name>
<Condition class="com.fr.data.condition.ListCondition"/>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="1" r="2">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[Conditional Formatting1]]></Name>
<Condition class="com.fr.data.condition.ListCondition"/>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="2">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[Conditional Formatting1]]></Name>
<Condition class="com.fr.data.condition.ListCondition"/>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="3" r="2">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[Conditional Formatting1]]></Name>
<Condition class="com.fr.data.condition.ListCondition"/>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style horizontal_alignment="0" vertical_alignment="3" imageLayout="1">
<FRFont name="Microsoft YaHei" style="0" size="80" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G!;;cgPSVUOiO42RGhRF3RH=YoGfg5[.)8jW$8:8bKO;ps57m0o/V=;[t,&g<*WSD/@,<X
2<q[2Kc'b::d/>"fMO4@4'=Kr@9]A`"F1X/fm?<8I-[MGsC_R:-37B"jUHK7Z(t@C\\3IT7-G
4p@%nGhtMQrSG-C6hRmmJWYN^C/R/&A9>>pcfs1jVA]Aqf7m9fksqk)`XO0Y*(/,J5J^OGU[b
Z!(i9$o*]AakH:Db7hR)5&Yakk[6a!1TEG.Nq=UW9'F]A[`&?#'s8(^KInj+prV4^i]AOq_HID4
`3?#<Z7gA7e#0"--dH+to#BHA>(>?mF81L&QX_9Z[9+m`-.m.T<tUF?_<S0G]Atre.;:R'j([
rXIYH?iQN4QW"'CFHOT.N:V)Hp=:,Y:5sG'f]A+#Ks*LMj\>LI?QBK71opOODl.NE:WHC?N&6
6G:i4<*M#_L`YO8eqr@bdg99]A2Moo9%^TO8_/bC`RWjD&-@<*DUeu^[i?`%jc'C)P-@4NUEZ
a"m'SWp&^&^ea%'07t.2F?D+3UZtWh\lcdW^H#)77[g'@a2DhVq%(3cR/372;[')Ztf6ma8c
#IC+%2)R[@iZ[g^A;>ed:bh@%X&@kGLo<==Ci9=C9Bh:V>?!5"G`OWj]A$Y]AAOMKulYd)07nN
S\2LYA(>k^Kin^l*q>ItlW3M%C0CEG-9XW+8NUsg$Q[$/ET$+[WW@p?Lr6ur*X`_I/+bb:aB
MD0h@,PbuVM;%5PC\:fiICk9A4,mps"b)>n>>5Td7/PAmd1Y9!"5G_Vd=)Ik?.:k+[^]Ag32A
q@`J)XDTb`K4RRhF-"+A8bq5.s71-AMSX_j6&:p:;5'QtSKSIJ16d[Aju#"Q`)%83<R5VIs/
<)ZT)ArEgUW[10]A:U.--JDr`/3+N@<18<lL/kX?NV"H$0^ND)'$`mo')Z84Zh-=]A\+)-s7OD
UI[./i)2:bYR/\,-;ep;iQ4&(/]A=((\P$0H@[E+oY2GX<b=Y"jl40gW(bJSD.'/B&?kC3<S1
@SEInuuS=nC\5*5sc8mWE6hm&Xrc#8ki]Au"pd(WJg^lj=-2Re1E#3Pk]AQ]AmfcA/4E',FY3="
CGburpHBcW$k#2r;';gWHtS.h2TKS+\fN1p$KDF,-ksajhLfXa-H'JS7p!*AXFR=3RRXK_lq
AI;e)Y9S(QGFec^UI?log@J[Jml-!=X3j(L0A_(EGmIl_5eB.Wlp\/E7]AeV/8gm&;eYdW$I/
c\!X:a9&D,<7\(Y$G=9u(aBqOl]A/,(Jlrb:]Ab6]AZ+9V6GqikA::.!lQ4T-R=sr%P_EoiJR-Q
J8.OVs.iAq3m,IE@=UVMZ2A/cQT6m<9b]A[Vm/=*N4Q";RYGW]A3+T/?X<:>MXu?V_/S00bd"E
u;UJ?%pa&=JN<-N:OLr7Ps4.7mR&4W1]A[Z5=3ZQ$S3l:4gPURW@1%q%YB%j4`fHbC:c<2lEn
aD!?#&X%:FcI1D$]ATC9Y=1!og5Ln7ri(sgD&S#>>[*$Iq#p<iq-Ru]A(`#^g)9^qo.G&u:Z;B
A&Bk8K5YBUQuDWO37QIOI(=f%ff93@M8Ml=TmWb+On>nJf=G*P=,7h%_ia5n*`jkKT^RW@dR
eV!_lfSB/qgLa;2SNFXNHD25;@LQLA&/S58V`MTfXfu^Vu"bDKeq$#L0F0#R#lC$kmfa/BVN
u0B"E^hrb$:fED_jLJR,\Z<o9fps;XH.i^hlSqr(bKc?g8oJKPfPeZ#&Z2EO3i^5F03@%'3k
r/%mdUECdO!*[2oLkFGJuuN'NW":JZWPQRWAThb\cpb"?N(0H6"tBqoj&8DiV"@1V,IPsJ@@
cIGopV;1>1YY;d)0rG6YoqJ)1pf,o!=Zaa\P:mm),"D<&GNRerA7A#MLhNtq2FuRVLD)5/nb
Ja9r!_<$U&UW!Fp/#)^1f+bk.dC\'08<!oNH-(%VOdELcbI5as8BW6BpBo8;-2J]A3)[A,RWr
`@GOqRRhn6s\-^F>%C[O(-V"+m*t'25dgJZ"TA<[,h^k0Ve57$igRmZ"AjY]AWa;A\grjgnc5
A#3#"TIbK\\$FD::n&"V'FnhT<k!oG*EelN"%dgc8KYNO-nk>QpZ+qa!to24ZGVRX8X(:(,E
NL3)#BG&)X4ViQ4BRo8N'jK6(_F4GHH[NAjQJ/#NXbPb<u>'s(gW+$GK='Oe%bG]A&rpd`BOG
@IH+n!S$um,Pp`]APHW,'L'[=i@"3Q7HC=k]Aio<25o-Fuj]AQ7>tVs;.\[=4IVF1fH7eOr9lEC
<e,9D!CcMu[dk,`05'@!tamSXpj0(`m]Atl3mhts+F2OqmB&K)mDoe1Pdd8WJVKEs"ZI;JcN-
F4GK+4)'>#fbi:IJIE$Y\?flO'f;gb3i`0c=+(H=s9)gk4rI:P5%krG1%??41pXiJ9Q,@)_?
iP?:Nb2hWVc$HYh"5T`ch<f':K7nQQ(c""7E`FY_%^Wl3Yf:,>35?sM>?QU.##KC.eRDM1,+
\%/!]AMI5cNSWGUg7)Olt)@a+<Fk)r9gWI3nt)[u-@u7g";q>VgJc33;9;4YjnlP*lpPM^c:@
?<>L+cKLY8f@iR3`R8M4n%T7nR*FMh0L2=o1KP8ZGaW*6pHZuZ_UdC3)85a_FQ_Dtmr7t`)K
b3U+me*]Af./'\6&o,P#"QlQ%la&[`34fG$IRK2^6oVKFnBM'DaJ@8EOr&ubcIE-H!ccO2I@q
%+9fmn0_%&X`CG#1'703X47c1#pIW%!SdGd(Qaadg"dH7STZ-_W0t<M`EMgN[G.F+kT"k$(!
F$Ai@?JooQZoa,SbsKtXo@lp6DhkGJ8*Rk#=C(,D(4&qVfP:%G9-%49se4uRH?R@(Lkl7SBr
`54k(QDHq[m'h)'dG[&O8OU#;gTn^Z+p%:d2*\H[-l4+jDIX!:'o[fZIi"-P@"_-qYfa7TaB
+&tkH@9Q7+$#1%qGM`q@Iab@YE;A"Nf0TlNM]A(-#b/iKZqLlu=^/j$Ol-pJI3*/I6qX.QXV.
mWHcbI!`""'d>-$q[t63QbSa4F2plXok7InN,l@]A;uuO?W*BL<SI;O.G_f+rO&!$3&UCZ'h9
2)HRO3YKhIs;X@rjT)B*nVc_aNkWC*&Zc7YiAd3Zrcp/#JTB#a\m\?-,TEU@WR"S!*8tIN.1
A$<6\C50`p/BL%)D^hSL$\I0D_?JKSLW4^[NnJDo<2e`I!ZTRronU#qps)/m-&nkm^f6c+,;
9[ne&irmO+CdYMrZeoRfc3U1M)%\C$#:b'$37`nO&r]AFrQ=m3r*Or%Wanq&[gt&Si]APbc=*i
daL1Q]A<`l/M"k/d;(@=6]AC=M[7$W2l4md,8o-0df)A$C!^4?<X)9pAVd$X9tW[*;gWh+.39I
SlDU&f-bR?ei5:[l_oZaDdAQ!9WWQ2&ThXO9UEXo)N'r#J5>b3scsSi"aN[7cI875;(D3>UZ
PEW*0pc2TCf=c;%*30!\2R+Q35+ItJL7A3iXkW@CoIXO5'nPPO\:lqhh&>48sV^M4EHtK[nV
:0>Nn9ouIZ@G]A3QF;b1F%\@%hun=K!nUt1,4>58>('6"5*MXcaAHtu@H]A(.Sm0'fpi]AR.aat
2`>`?Y_<i<HJ@U^<6eNl=j$-mWsDIl.+OH^*V)*SW[>)c=P!%)TogkEJY=!,H&28EJYJ_SC!
S]A:*C4Yaam=?0%B)W-=/Dnsge7]AF`uJ_P#"G((!VHoJ7Z9M55;CfB^/[dsUZ+t<XedY"0):#
ke1<*<h4Y%Au_,N1sO7d:1V#.SG/``ac,pSJ#e=\fk1/odTO',q@UO,Urg6#ADBn!j)fZ=]Ad
m"DD/s'NMAj$37&JMHe4X^WCg%JPTalF>76U(R."7#enASEB\B!&D8?@D8Qa.>6[sF_a&=8&
@dO.U%lpH,\?FqP\h+lpmi<qH(\<'ai@bh2=sCm8S`uNWDk,ADV-hd1,F>s0:L#&MMuq"/P2
"]Am=V"!:0`3EeS&?qeh3Zi*hX8`s2!VrKs*YG(!dTaYGc1UggYZX^:1$dH]A6&Eb-l3B3Zk9P
Vi]AjB<Cfs['(,WdZo<QgP2@>-`3Y6T-%F6[adn>=34'mLnS'@n<+.TWNoO($Q%\QfeWi6scP
@:F1:N<1X**RT3b&aT=.Qs%V:FP$Am;pHK1,a@!$E]AT;@\',!7LoX-F4HOADSE@g8$t;rH"/
)%iZ]Anqo",gV3Gi`;mqq3%@b(T.M4r<Ecr'G:(]A"&Le#;P<Z..DN7ap@]AP,'I`QH/hF)5=Bk
TL1K'2!`qDg`YfW*-dR(Xt8Th)5R1BZm'r.[O6tp8iY41=Kd3i+IqIN^-V@f,^^9d.&lA$6.
-\Oa6>MYoL5fG<jID(CC-j(Q55\,/LDVhR;7Zo^ujL..g&k>/lK%O%hpZE<rZ_YF8q+P*SN+
[j?pP-'9=sdU1CEjmfO=`>sXt6>sJ@%T"W:n)&bb!4Zj38mMYqPV!RL\pnoO\REG.'e'4kPN
[Yco=0WqG:"U&MFhi6iUASF+bk]Ao9S2bh)g.B!I?GdA\-7Oo*JYO97nh%>&-Kj-]A.a57$'`;
V5q(/8i]Asa)X"IU]A`O.Sq"Ns/-n%0hc??.Y]A:a=EE>Ui^k2D5bPZI0D3ILTib/VkUr,oYC'R
4K,VV!N%]ADLa,LOEmAR-RX44>1&_UMNn=c:^0h'#"hdL\o$[q%TR3J-r;ZD:$AFM,"?DEUEF
la5n)Xo(K*O90O(e73AW`W1V`W5^3IX_glFL<f4-L;%D\\j=KGbM6s?RHCfa8q^B/FHW0_-P
2D#pk]A8ptEC_Ol]A`>F0j*:JerQ!+V.hm%K]AXBp:`4-p(a1:A"X1M+/dd[T5riEBstN.6AOgU
F<^BlrTa:2H!SE2(Bo.+W]As#9^rL[=9REr"G^3E/"a`4W5'59eh'7Rq$LZ_d!Pcjep8_7!I5
`R_Mf'T[5&;2]AE6u"`UkkF5*1aQW.^M*#n1A9+$?q5`X>[K4QR"&eZqU)Xepspdp&0-3+%9I
2^5]AHpqL`&&7O;$_RJ_P/GG"lQ@/WEaHu,1i)0g)-i#_q\VIm[PeGTDT5'$^p_e90818DM8e
\JCn>$m#UJQO+T7QqHkia3/E[X9hcCdl>Q+uFp(+r*d5/X^nK>fXhR7P/#nnjaJn52fIi,+5
VSF#kra["dP9A;+l0G5N'O(R/ImTGiqo_3*'dOW9:]A4Krq1_+`r7=M4kP(Q.p7nABJVU@!l4
:B!G-"DfmDmA#XnJ7Y*rAtnX[qo09;lh0*$8/q\W7LR4YDH7l.c9[T2p)=IVEE"aK_tX5ia(
Q23eKqnJE1XE<tr!c8'(@<8<ef_oeGQ)F+nhX6[31<2lFu"sQ=O[P<[E`&c>aibS9kY1[Cp+
\p,@=KIe&4:f#!h[H'.4[/oMZTWC>Fl9tea/>_e6SG]A2YY'm.O:TFo*Wm@3p22U7YBgAF7q2
9hq+T$f"+8cYAFFKr@Ooc'NqOL3>X3l7dU&O5:oWTfIK0b_$UmD=L(Ou$_1f_=pR17%>AP[C
iB<o(S&E4gYA`P5FXUZXoK'^+X_fLsRpMmZgc_PUO5RW:*'H"_JjjpKFTXAl$*38TaS'?*km
-3UeBu=h]A'7sYCC?aLgnD"2)CRB-*P0Q0dt;.?'QU!6A^Mk"0_<Hp!uDH#*WlH8]A!9J]A!u?t
3BAR&Dl-7r1(-0/_N'Wn)GS9udI.<%B&.3W*n-$f5IqfTqgsLr*.Ke9,oE9Nhj-]AH.ELFDN6
1BFjUr:H;1^'2\Vt;+TfehK)pFWJo(J>D%?:^0$O2ilL!!H93\um%'j\;oZ0OUk=&+RSdUe+
72@R<N)Fjsje1`c_6F7*PBIsj(!<Ub0"ilp/uAm,>qTQ*pXS:J*,cX`+fQT)a&&7ZoqmN_JZ
OjJiC%[[p4b?_KsOaA#i!lti_<d7r9ARP<8pc*`P*dUa`&'Fse51)!boYc.`_RPoDWGBCc&1
"TY'S,pNSu2uX="K3lHQo3184arBSC!h5r//I4]A86ZPlj>Y8@K<?b%4N6XZ\["h*u/7)k!>^
BNdb,_K/]A>u>o.5Nb93N=2hB6Xd8&=hGCdDa2hBc>L(DePE"gs87*Yabe1;2fA-s?5(64N;_
Z1Ypp-u!j3k<LNpZ1lnf`Q.#*C(Cf9\sDpleLn^l4[1%(@0XM/66I:e;HcucYDrN+A[1q*I-
CK:kn]A$i.(rHPdI[g\M>Q[n!c"L?bM^2748Q9^<%/#:`]Ai3CAMG&O@!gAI+9hqQ$qn#_XY*k
A!2?:$pZpR^/JA;(O<N^V?[ZaSV5PA#O2kq0*X5K'E`!"]Ap<FhikE*s%@`:u&1jqk.?k@g(]A
b!;:oF[P^eZ"0"E*'>Alr]AI[fO/4OARPQIW1no&,#dLb![=0NZ\9j=g1SXalB60@rigLI1'S
$bgRS!#G-#3AHrS&!HQHS??t<r!g+oIp$`pa"\`,SBSp:-FECK.(jZc^=>9`Y,V6ZX6N0U!I
LdRJ:T9MrIHUu514?2'kW$F@.h=-B!"L=&`WC=6k`L/f'%<!MffL5T;(L=9PL2a:YhX%#s*I
<$ThGac#H0oB'$$j7[b*#W5j3Ctm1UP``%NesU&/0=k(#rl!8&I@>Ai$T:!=;e&t^WXGV*mG
Wt1->bkUBs%UJc0AWIoZOC%PQio_AWclUY1`TB#n;0]ASS5W?)D.qd-=H(UR<!!3L6>"kZIKr
_I9b</+NntLHXSgGIXW=/BVcY,!L;0rF9BD_`OPYG,QdGg3%!0p1)B:(mMk,SW8%sVoI-3^T
1a_uh5@PaH;RM9k`!&&ud\Xu<C!8O*;<KT$ZFEkR!e_qn:#+$gnpSah2L*L+k:aDDY0<b3\.
(kJ$O8YEZSoMfIQrIm;gX_'a29.Pq+<JD4')cbtma8XE5O,`e1;G@k>W@<rRW'8g3ZR)rN'i
!c6hp'bIUMo+jHH?rXI3YPp$rLD^HV[u*Uit<~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="915" height="89"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report2"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList/>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList/>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="44" width="360" height="81"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<Listener event="afterinit">
<JavaScript class="com.fr.js.JavaScriptImpl">
<Parameters/>
<Content>
<![CDATA[setTimeout(function() {
	var $report = $("div[widgetname=COUNTRY_LIST]A");
	//获取对应report的div元素
	var $scroll = $report.find("#frozen-center");
	//获取对应report的div元素的滚动块元素,冻结为#frozen-center，未冻结且未安装自定义滚动条插件为.reportContent，未冻结且安装了自定义滚动条插件为.scrollDiv
	var flag = window.flag0;
	//设置全局变量flag,每个报表块需保证各不相同
	$report.find("#frozen-center").css('overflow-x', 'hidden');
	$report.find("#frozen-center").css('overflow-y', 'hidden');
	$report.find("#frozen-north").css('overflow-x', 'hidden');
	$report.find("#frozen-north").css('overflow-y', 'hidden');
	//冻结情况下隐藏滚动条
	$report.find(".reportContent").css('overflow-y', 'hidden');
	$report.find(".reportContent").css('overflow-x', 'hidden');
	//非冻结情况下隐藏滚动条
	flag = true;
	//定义全局参数flag，用来控制滚动的暂停和继续
	$scroll.mouseover(function() {
		flag = false;
	})
	//鼠标悬浮，滚动停止
	$scroll.mouseleave(function() {
		flag = true;
	})
	//鼠标离开，继续滚动
	var old = -1;
	setInterval(function() {
		if (flag) {
			currentpos = $scroll[0]A.scrollTop;
			//获取距顶部距离
			if (currentpos == old) {
				$scroll[0]A.scrollTop = 0;
				//若已到达底部，则重置
			} else {
				old = currentpos;
				$scroll[0]A.scrollTop = currentpos + 1.5;
				//若未到达底部，则向下移动1.5像素
			}
		}
	}, 25);
	//以25ms的频率执行
}, 500);]]></Content>
</JavaScript>
</Listener>
<WidgetName name="Country_List"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="report1" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="Country_List"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="1" left="1" bottom="1" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<FormElementCase>
<ReportPageAttr>
<HR F="0" T="0"/>
<FR/>
<HC/>
<FC/>
<UPFCR COLUMN="false" ROW="true"/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[1296000,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[288000,2743200,5981700,3429000,3048000,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="0">
<O>
<![CDATA[Index]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" s="0">
<O>
<![CDATA[Country]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="1">
<O>
<![CDATA[Confirmed]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" s="1">
<O>
<![CDATA[Cured]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" s="1">
<O>
<![CDATA[Deaths]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" s="2">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=&C2]]></Attributes>
</O>
<PrivilegeControl/>
<Expand dir="0" leftParentDefault="false" left="C2"/>
</C>
<C c="2" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="detail_list" columnName="country_full_name"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[Conditional Formatting1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[row() % 2 = 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Scope val="1"/>
<Background name="ColorBackground" color="-2040098"/>
</HighlightAction>
</Highlight>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[Conditional Formatting2]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[row() % 2 != 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ForegroundHighlightAction">
<Scope val="1"/>
<Foreground color="-1"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="3" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="detail_list" columnName="confirmedCount"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="4" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="detail_list" columnName="curedCount"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="5" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="detail_list" columnName="deadCount"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="Microsoft JhengHei" style="1" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-39322"/>
<Border>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="Microsoft JhengHei" style="1" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-39322"/>
<Border>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="Verdana" style="0" size="72"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="Microsoft YaHei" style="0" size="72"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9>!@'6gmnla:n//)BTqe;oc9HaiED+BfK`8TJ%;DX5ki5IQGWU=)Xc6I^Mg-CJ[c/[nA1O)
c0R@8b^8e86oi64>$*.O(^ON"@ir+X:A-!L&(^9dZ8RGHcP(c1jEnEUW>/Q9R_r^[jPM4n!a
CRGm0j/RA;<_il/`1M4k+0E5J>lXRqnKu]A-t!.F&slB>MMK)RK73:FMmn:`eiQ&]A`_hV7AWT
<1bdp7>ReiG1H7+&L5Wh;735^H_\`M`E6Lbl<h#e;"]AEff20:rF_%d=3l8*CuoKdgE1UOleC
*g(uDY&0D`j2>P!&":R*_<cAfZ3Aei=Ba)]A)k#Ur1N4h6[d-_aMb3+pkiHQmg9*LRMd>"\FY
Fb/5/$MLNXL2*NpB1pkk#t1;!'4<iX?$'hjOdPeJW5O%S^]A'Ms>[pJh=NF5U3pi=_9U1(VJU
,q:,G4ZK8*oFo6gH^FGC1+jCPcrgfN5D<IActa8W-tTE5V)_#5aAdn9d]AqBPha#8en9".UL=
i\nOu]AWB:8n`5hJjnU^9d[[uP06`m$*=r==D'*T#!h'N&6<hU2rSQGJ[cY&`[]AIqA/(s"48`
\"6R3*U-MRI>!'DTh@S\$;U+/O7'iK5@#u0;=KI40S4,k0d?q-mbtV$MX@Pp'AcHq8?83;eE
]An.-K3EQAF5H@aD2D2V8G$.Sc<Z*'[fAs!.FM"p*P4/a'L/)nHu"<nuZ8DEA78\?A/sh$Xq:
pcr"+QaKe5^l!>.58.^3XT7<YB(slWfbKaJ,Y9T.39aPG+X!cDWH?0!m4hsa!?=F<2s'*(mH
g(^>R=qiUB\4X2"s;&VOB:TJD2"2'0A3e<4j**0L*`P]A]Abd6Siojt7kYq%kC)YlTQ^BFIQ>5
IO(e,B"c=kDo?%6&[qHGaMRr3p117n?"U^Wh_9!"?0]AW]AVG)3\jA#,ic9n\NI`6#CX^gJ<`R
jZlki-`*=pGAG:4BUc/?5oE7.=\eVGlT8q#4c7McMh5O=fk3-9TJPKied/.6AqgY@LseZd;q
>hbgonmbZ"e:"bWZ#nb(!:Mj%3s<E$ft3Y*'1SrJOke!e3L]A6;R*\4]A%VT#\fG#Bnj6<Mnub
od6=E\6=]A%.3IDDk6.6bmu0_C$LFur9GJaD.rL8l9sMu8XRXf2VP:kI'HJ1C)H\&?SVJ#"Uf
*haEb5mr%Bsa!2(4Q`Y$$XSC&NX[!X:Q3j-kI^/2gn5h10$f-$qS9&1=0;/(A]Ab;?r\+"Ui!
.nW:!mZJrDiLH2K3VL&=gi]Alo(@^`PHJ;#[9O+T'Rrg09rZf7&UNJ,[P;^oc"\MJi$^GXl?o
uYEV;f+\\,JE*dOspQOLak4e="Fr$)!kGfRq&BR-rtZpD/A"<JtE::(0s-R[m,cV^%-eoW;Z
%#3uOQ'%OCM+Cn"Gbc@-tU_jXq)@dgj-of.<29)%OQrp<qV-q/%1?]AJl`j0aIjGK/c;Dr$DB
<*0O5J'FaPFX0%#/MeXa1m$[HN,r,o8qO/WQ[>l+9FbrMY0)t+@a5s-KY`WGRT[-dj%D;,$5
k!?)8\CC=kIMNA->/H'cr[b,d\1I<\"OXT'&H!U-,%)4*D/!l=(1^0Y"i9kA>tl7nDKo'f'J
O&TaQdGJOFk`\[^RR[>mB0o"h1_6`/'M"U<p9G+0I6(ra7C$/"'>n5;/"Z]A0nUko>gXgQ#A_
)Ofo;DudkZ^OC-Y9C:5Dhi+>!PqD'4#`)Ep:So:+(qQ>##+uZWU+92KpYZ)h!qtdb65hK\;q
pO85<=X$:b/&f[c46"*[6G"!H<B<bK[oKS6/kZJS82S"Yp-bX;SGAPHFt1]A\u1.BRr5JIgHi
4`fgYnWe*b[ItB%W8-P"q&&g6_q.(kJ#Wo+AOn5Bmq=$'3(RrZ1`/5rKDa*,oG""@?``jE;^
Dr_#c<lA6!,U>$A1%Y08U85o@[Ucq9E-A]AA2E3`CaXDM//A.Hf2d.o>(mt*t+!b-Qn7\VVL@
<j<@\!K_%Bf9On;oaUQSOM5QWNKmIQ[lU`A!XK5B\1*K)L6",UTE?Ii:\`)F8.e)?6Mr.J6]A
B494cO\O'&=9c\T7qVd@C,3%J(@NImVdW=1APk'AMDHX5m!c_lPClo^tJ5VBrJ9ogMU%6^kb
l;?bF4H,>#8(>2fIp`<Em:e\KrCfNZ8q\i?@A04Tc#fZmBo.WZY7__:&*o8(b\gPP4@-a^2p
`<7]A-$M9TA$fh4YpnYRUX:WGf7(hF8s7WRQWm&d'J>+^ZjBNBIkfJ\RL1G,T`AN/r8<Q=7Jl
_V7[W=2G;2M]AH7e41uRo03_#q'dBkOPf<(XNN6_tu9?X>H[FD0da')Hhfqd]AO2]A/1><m.eWB
$PR@IDZa'.i)T^krKg+`O4WtJ%FRAj4YI^N#^L.gd.0D_>nnTcDl1OlP(b0]AS,L=nWZ5jqY2
VD>cZfbF"(&)&/H&OG2FoJEG;ddRj_EqL%HJIr)Mu&kcIP;W/oX%Dl^?.rqBe<U:V4$?()pL
elH1:G+$Z=L%bDFuhNSD9HTUT0FQDXLCB,Ai-Ld&3likGQ@\q34::u@t&[&iXZ/NI<]A:Xfat
#jfH58d]A^3VV]AGYI$=0t9hY:Bq3rL5W3Yl+@ZMKDTt%#`2fX`0`&ldLd<nT.0I_u;FHNDR+_
b"@n$en_i^ALeEo-.u32>#H8[sl*>fB^mps3/aJ$6KU-$om_Gnp,?DHXrh=XqkS<+a*PW7qf
i&fjtE=8dgrXh/*)IRF.>]A'-f?+!<eMGp,mkW6m\kdhGnR3%lSb\=DG,6&g(p4EuZZORFGOr
8?Q^[GDDqD+Z,^P*o[cet<r<Er3cL(^>Zt9ndRi7$8l[/g7nW@D>[mXhhBDJWN4qS&&jOLBY
*g''3`[><3$S6A>`S@RNnudh;*ocRW3"\<,OFY=8<<aBXb=%,D0&nl7Q;_+X+-4FAG*flq(B
fN0102a8PD-<"8n"b1C$HsUqX9q`!AHGAa28o5K\GXLA/o*G`s1\*Y7:F>VG)PQ\%"n%o'q,
4/0IZ1%_7`q(qY2Ct=Lm:\a;,abI6fKcpJ'IF*7$UWn\%=KlGLV\:f'blD.@H8FR;uJT]A3"r
+Q3"sj%.q@sj[NI'plU!gT]AFbW\%%G2D2Wi'G1Ud6?QG]A-#c"teW2V+4r6'+"ebt8_9cN]A>R
IBo_NX.*'7$T]AURI*Fg<$PiKicML`Jj_pLY41(ZjlYR9j<JP7n7#1A@OQlH?6p@Fc*c4%fLo
3m(Odm_rK>$>ogTk]ACcTX3VWbT:1+7L!q@V.pUoCdiWBU%4%49rXm5jD;k!.5eU+OqK7gj=2
9>P"h4lrf.A%"m[1,pl@hnt^N$"?]A_0oX%C_lXNQBP^cbXHW<;_L9<qBsC2[&rB/goo'<1-R
pDmU&"'A)RNHMWFb&.pdc5Hl5DqZS0rFkK=H8[Pc<-A+4m566&@KUF3^ne`K<[?qq:aAP3jh
6M*b?-s%Y_scsIQu>t@?fPPrCGkI,@,*"'C*MROI+0Gfu\!g'tf38Cf!P)b5`18LhYc.&p0(
-@l@*kYR<.aW%ms#7Zed+bssRQ#*ghm9I]AO#=C`24JhuXSt1H0kftB-%]A,g)4\4B(dZ.]A%E[
)t8SX5""^SrWQ0.J^Uo=V<Q>ud!_R(Yc4t\t,ldG873(3BIEs7OV2NULmF9/o[eR;\s)li'(
lC2e:eh*qYPo>K!"m=`foKJ/Dhn^\\$ipcD>+]AQ"(#R_\?gp%<n8MY1&^dkWO<Z7k7bk:Wd;
.b,(;3B$8<0%GFER<_kK)%&!@Z4*h]AB>n-9iUZcGM38_\4+C5nTSm\rbnhG44_]A)Z3LCl,dr
Hg6NbA2(6k5;G/^#@6b(50PUXVbe/[DL8L62l.L)60('P)0XhK#D!9MN"\<4dkS@/BSF&E=q
U@'1:nU).>19j@[W*)tO^jj<<M:7FL7$dWT\g]A`l5R`Q7EqpRBt/%,=c(Y+#1AgSgR2liPaj
!Fgf%,(M9QWPQ\#8M\eOrr3OZn4lBdZedW0:\&MA"mO,(keE48)i/jQ9)Ve!,Ncfn[1?,[l<
EWHb=4gD247p&YHVSadPj&1/%G1>=8*VYgh?BMC;5M5g*=,eo"0,B0nGiG'H[l]A3'-p$nA5%
"ng`._&Z)#%Yq-7tNd3FQ/9A'=_!<ombQGAR[n#rP6l.f#&TGYSi:c.ud+f.M(Nfu9Vt/uE^
@PEGbfb8'#]AAbR.;CCn(4#r@_*r*p=Y#q,X;Dls"`p!tY^l!(UM1?<,WI4,ob.Lks>`<r;B_
&K"gYi=4VOk3,Vjk'sc*/+f.T9?)K]A__s@8_=-70cl,r>$>@,MPCH:J"IC(65"b$_K8Q$IRB
eKh[+!<POuD9IUjLu=Mf;&pI3.aF;'8V8Jb^0oMPBj./C^E_?LY$pt<M*E0pYPnX:.\J$>7b
`lXUZ3!bj-]A7>NodL"*_K3n90)NM6\Q?+j8Cr`l.bU?c#XC$ce=n&ecP??&UE6R"46:1#'"b
rW"@kBr'=+7L\3/&W\>ZQ6g4feVb9cEbi9U=pg\ZV##\&RfFe<Ak9Mdga)f.2TmH4gQ[DCS+
.<T=\s:4?b[UCXXeg2+[W`<gLgiZ(]A'=F:'sLBgGD\@ps'eA7k5V_0IEZhAUSp=m\C)6udT^
ao8_p`Vk4fKEfpVUr[UMsFh.`+;UNSaC_"jn\-Sq!?SectYt;U3R*g35L<5Kt^khkF1Bq9#N
I.jIi6=eHk.[3$Ftn76)7O<A5V-0@?*aY\lH\\62-*5q/b&.X@.k!UH*R+%$Bs?.C7sOSZ<)
OSqnE-sk-.iZX9@P:E'F\pW]A$RYnRWR"+6poVGi8X0CbZlg7@T$)NPG=QT9>?'h*=4"RD@fA
LD%Ci8NM-\UbX0m=EOFN6jW8%@Q_RO&dp=+epdlV=\e!#=3n`mW:V;Tnd^fW6q-N.V5,j`/F
ZhV!IG"]A$:9RrC7%.7`2i,)Is$='fLSkf(,B+6C3E\E$J/D9,?^M84u'i)D.1`BN[,.FL1Y3
Anqa`P19lX1kU\$E\"4nMWmWZRiM/$H9d8mo,sLW6f%&V;hd2WVqjloiYED87SL,/9%Dc^c>
/6P]AZlSBFe5UW$2c>9+b]Ab7=4ZhTcO]A2j2ni#.9+VeSqCDu$W]A)C0FCPrc[_;]ADe/A:Pl$_/
*G!#+3n1sL^ij2E@Q#\^SR::u>a)2s@`"(.-7It4pU^FT^q\If%MqiP.emHH1=#&r&4DXA'$
LaXW><=Za8-A\Yd7%VrN]AEkeIUG,#7I)8S;0:"HW9nnqg*P+:T<5'gg)"<&(`)KJ,/HDloMF
PYRS5cOMK7Fp"8s9gq!fLPLV*EYalpogI/fK\TZ3ti#?X)UdV0Fl\LH;"bttmP#BL(qI#!C,
6W)*DN:<1kP1EBm?TBVUd`K>)/lrDSII%1c^3^,hmNr*^,M?TX5g8@X%ZSh\,;r\\?j^#*+s
VHMZ;N%ld/u4jNq`JnZ:c'7)>7d3c\/XDHcbaVB<amZasVsg]AdC3J_RciD`h$[f#0jC'fh&j
]AUDr4V0Z%>niK]A>DBtp7c-!q61-h,0A=^R7aS22C;2RbD<?:IfW=YptG1fX"T.0VSq">uKO;
m+GFij"$#Qlm:GOPA,"m'Dt<"IdQ+nMK*DR5PP9(j?\[^G!#a/*s6:]A..2F[U?p!KM&XmPZ<
EU]A0E/fm+YWIK6UKN;Y3B=o#^Yr7ebik8IVl7o7bD<&@BTrQ38^:Q2B.150=aE9l%fG-8#u?
G%Z"*o3"_a2XR(g'"o9WmBMe$!)XQNcmieG+1",e?]A2jE228_9X&ac$4O:49%)'hT#(_pp?2
)#k,>9B3K!1tm/Ek>7!I.n:jr6)OB4r)0A:HYZa]Armm8%8`T$ti6q>V<IVq6:fL%iO;.4[nh
nHK)4N%('"9ZI5,iT+5g-IZF\*2cK:isk`2F7A9eXYe$m@>+B-Ab\pG,3?&J!kJX$DLKi/96
["_F[X:eC@,N=pQWq4RIc%[::c=#n/NdkVsfJGQX5rP,pak9SMijiR'::Y8=!#gm1a.lCPH!
!g7TZ6_johq_SCatbQ!_rF#4mtNZ-Q=2Hd&<9)\l18d[_'?P7dB(%:DO\b>+sRcJ=/"!F.PD
`1ehaedYef#%6XM?>.Gg@N"nWmUD'giQAlp;bW*M&+ut(Z8uC^N+%gU8trVJB\t6d8:]A>D$K
Fl&O3pjq^7'a)\FXhDc)@c>%Y``3pqj.<*Mj-I^Y?Ha&uB%$MD\)'3F!G?DQnp.Y)kGkjD&(
C#ai9%n;K-HcA9U7nGBOmMgms6SI>ipJ5CiVW)\KSe5'7_N3LlIM!5+O[t^QU8tfZI"J3+`l
i\$@?eVmC0)B5VW]A$eRi#GB,G.2qa)[qr7R#ee[llBZ6g<6!8bYV6LsD8lE8R;L]AkF4Sb8J:
uqS%k8kh,?>(U-Z:4o,Fh:/`'$pK632KU2;W.3!S2Q_gR6Ft<h,1k=7kE<fiDpd]ANC[-m=ji
a"N2L<hL2T"%qkC>1I)9l@/\m*X@4e@tA"A'N9LfNOR6e6S6OI(dD:&cgDFb/S_19)]Am0r9t
nKK8Qg98M3K:`J=K@,Y!-U4`XMP9%,?2WU-87Uj-*4+%.oTjXt!*BkUo(^2=l-fU3`*:ekf^
<k:o[@Dt;e!UD(`9Nn`Tm=kCEjcRq#Ga]A?ib?bHC:#!enGWKne!M0!FCjPH;cJV8TXM.kujs
901e$UU%Uh;cD(K;TP`jhn'lCU?3Y69aE'I`Iq;:FZ46V+F'@<53Wb]A==Z=t'"NJP[ZHeJYa
qeCsG@pMVDj5%CmK+5[5+LX*3[F"hp9BIN]AA2^Q?/W+Y2UaS6&&!CU#.VD+U(::g[K!I5GDm
>/dOOcYGblA]A$jBAiCV9C%G7T@DkU`":*#j6@iBWi'%jlB]A]Ak^B*)')ai*ad#O,#*"K9X&7=
7Ien[#!2`/8jFk(>PgI[rs/Qb_+ifK(jXO8-c1p3f4qXDl5J=OC2Qd]AA,2''u#ln.0h.hZPT
J-g2.3H$5B%T(V=ZGmQudOoga"KO$B0#*Z2,aK,<$4X?^4No4p&"Im&2`)(o6bE[L6GL-n(P
+.Mp0?r)\f,maO<A=ZLanj1+98-%hicC4>`Lp,>5Mg<Lb17(OWUn=r-!&WK)WjgS-q^f`<Gk
,]A5^-I]APE@Q#e1fkcoo5B-Z0-d6sa)&K/gM.onWPP2FS*'Ds/.lr$?G0UE!('j!i#73M/+s/
jrqCP'>^aLnFZtec"5=-B.SNLopA'M]Amh8KJMCaJ@-/"4Dj]AQ3g?be6>&dbR&7u!qpN9+6L.
d\b\k8([(N3JjN`j1dp_BAV(YbD7iJ+gIQE:l=0$#ha6W2\jkc>`_2di@_8XW-"mt%e&h8$L
#?]Ar2PIssc=&ka58m$&MA$kSg%nc!*><r,M,JP3U5phJ2*f]AI^iFRQ-<%rC<?*`2F!pt*"5D
"bo[38_lF^I-6.GOmM9e1'gE`[dq,Vgq1$N:!R',8'![KAAB^sPPA!mMZ0U\6S@aN4B\V<q.
E*-Xol?:gg(\-nsXqVTj4jW(J%WQH=[7/)9`KDBDuCX"X2XWc"fV!kU:6T^k0*(6M$LqUuNX
=ePS@R'Ad*FCXKEs8oPh->sI@iRu"\LpN2D$o9NR5"rKL%<VTdU!Pji1jJgW8]ATZ"%4*QNV;
R:04"@),s<,V+/Ym=A\^T33g`VhSp"=Nf3JZD@\`#]AndV@t?,<5.U%JM]A#.iafHDl_TlK_EH
K6A09?&d>bE>g&2U`oTee7ju&h`71\[PobZ*(0\;r6j#I#@Ca/_>aK~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="915" y="0" width="284" height="472"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="TOP10"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[New Title]]></O>
<FRFont name="Times New Roman" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList/>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="1099" y="136" width="340" height="581"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<Sorted sorted="true"/>
<MobileWidgetList>
<Widget widgetName="word cloud"/>
<Widget widgetName="Pie_chart"/>
<Widget widgetName="Trend"/>
<Widget widgetName="tablayout0"/>
<Widget widgetName="Title"/>
<Widget widgetName="report0"/>
<Widget widgetName="report1"/>
<Widget widgetName="report2"/>
<Widget widgetName="Country_List"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetScalingAttr compState="0"/>
<DesignResolution absoluteResolutionScaleW="1920" absoluteResolutionScaleH="1080"/>
<AppRelayout appRelayout="true"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="1199" height="597"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<Sorted sorted="true"/>
<MobileWidgetList>
<Widget widgetName="word cloud"/>
<Widget widgetName="Pie_chart"/>
<Widget widgetName="Trend"/>
<Widget widgetName="tablayout0"/>
<Widget widgetName="Title"/>
<Widget widgetName="report0"/>
<Widget widgetName="report1"/>
<Widget widgetName="report2"/>
<Widget widgetName="Country_List"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="0"/>
<AppRelayout appRelayout="true"/>
<Size width="1199" height="597"/>
<ResolutionScalingAttr percent="1.2"/>
<BodyLayoutType type="1"/>
</Center>
</Layout>
<DesignerVersion DesignerVersion="KAA"/>
<PreviewType PreviewType="5"/>
<WatermarkAttr class="com.fr.base.iofile.attr.WatermarkAttr">
<WatermarkAttr fontSize="20" color="-6710887" horizontalGap="200" verticalGap="100" valid="false">
<Text>
<![CDATA[]]></Text>
</WatermarkAttr>
</WatermarkAttr>
<TemplateIdAttMark class="com.fr.base.iofile.attr.TemplateIdAttrMark">
<TemplateIdAttMark TemplateId="d95322be-7794-4490-a753-90b682f480c0"/>
</TemplateIdAttMark>
</Form>
