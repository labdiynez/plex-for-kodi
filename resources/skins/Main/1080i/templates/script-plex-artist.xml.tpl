{% extends "default.xml.tpl" %}
{% block headers %}<defaultcontrol>100</defaultcontrol>{% endblock %}
{% block content %}
<control type="group" id="50">
    <animation effect="slide" end="0,-300" time="200" tween="quadratic" easing="out" condition="!String.IsEmpty(Window.Property(on.extras))">Conditional</animation>

    <animation type="Conditional" condition="Integer.IsGreater(Window.Property(hub.focus),0) + Control.IsVisible(500)" reversible="true">
        <effect type="slide" end="0,-500" time="200" tween="quadratic" easing="out"/>
    </animation>

    <posx>0</posx>
    <posy>135</posy>
    <defaultcontrol>400</defaultcontrol>

    {% block buttons %}
        <control type="grouplist" id="300">
            <animation effect="fade" start="0" end="100" time="200" reversible="true">VisibleChange</animation>
            <defaultcontrol>301</defaultcontrol>
            <posx>594</posx>
            <posy>418</posy>
            <width>600</width>
            <height>145</height>
            <onup>200</onup>
            <ondown>400</ondown>
            <itemgap>-50</itemgap>
            <orientation>horizontal</orientation>
            <align>center</align>
            <scrolltime tween="quadratic" easing="out">200</scrolltime>
            <usecontrolcoords>true</usecontrolcoords>

            {% with attr = {"width": 174, "height": 139} & template = "includes/themed_button.xml.tpl" & hitrect = {"w": 94, "h": 59} %}
                {% include template with name="info" & id=301 %}
                {% include template with name="play" & id=302 %}
                {% include template with name="shuffle" & id=303 %}
                {% include template with name="more" & id=304 %}
            {% endwith %}

        </control>
    {% endblock %}

    <control type="group">
        <posx>60</posx>
        <posy>0</posy>
        <width>1920</width>
        <height>200</height>
        <control type="image">
            <posx>0</posx>
            <posy>0</posy>
            <width>519</width>
            <height>519</height>
            <texture background="true" fallback="script.plex/thumb_fallbacks/music.png">$INFO[Window.Property(thumb)]</texture>
            <aspectratio>scale</aspectratio>
        </control>
        <control type="label">
            <posx>579</posx>
            <posy>5</posy>
            <width>1190</width>
            <height>40</height>
            <font>font13</font>
            <align>left</align>
            <aligny>center</aligny>
            <textcolor>FFFFFFFF</textcolor>
            <label>$INFO[Window.Property(artist.title)]</label>
        </control>
        <control type="label">
            <posx>579</posx>
            <posy>55</posy>
            <width>1190</width>
            <height>40</height>
            <font>font13</font>
            <align>left</align>
            <aligny>center</aligny>
            <textcolor>FFDDDDDD</textcolor>
            <label>$INFO[Window.Property(artist.genre)]</label>
        </control>
        <control type="textbox">
            <posx>579</posx>
            <posy>158</posy>
            <width>1221</width>
            <height>250</height>
            <font>font13</font>
            <align>left</align>
            <textcolor>FFDDDDDD</textcolor>
            <label>$INFO[Window.Property(summary)]</label>
            <pagecontrol>152</pagecontrol>
        </control>
    </control>

    <control type="group" id="100">
        <visible>Integer.IsGreater(Container(400).NumItems,0) + String.IsEmpty(Window.Property(drawing))</visible>
        <defaultcontrol>400</defaultcontrol>
        <posx>0</posx>
        <posy>585</posy>
        <width>1920</width>
        <height>360</height>
        <control type="image">
            <posx>0</posx>
            <posy>0</posy>
            <width>1920</width>
            <height>360</height>
            <texture>script.plex/white-square.png</texture>
            <colordiffuse>20000000</colordiffuse>
        </control>
        <control type="list" id="400">
            <posx>0</posx>
            <posy>-20</posy>
            <width>1920</width>
            <height>700</height>
            <onup>300</onup>
            <ondown>401</ondown>
            <scrolltime>200</scrolltime>
            <orientation>horizontal</orientation>
            <preloaditems>2</preloaditems>
            <!-- ITEM LAYOUT ########################################## -->
            <itemlayout width="260">
                <control type="group">
                    <posx>60</posx>
                    <posy>60</posy>
                    <control type="group">
                        <posx>0</posx>
                        <posy>0</posy>
                        <control type="image">
                            <posx>0</posx>
                            <posy>0</posy>
                            <width>215</width>
                            <height>215</height>
                            <texture>$INFO[ListItem.Property(thumb.fallback)]</texture>
                        </control>
                        <control type="image">
                            <posx>0</posx>
                            <posy>0</posy>
                            <width>215</width>
                            <height>215</height>
                            <texture background="true">$INFO[ListItem.Thumb]</texture>
                            <aspectratio>scale</aspectratio>
                        </control>
                        <control type="group">
                            <posx>0</posx>
                            <posy>220</posy>
                            <control type="label">
                                <posx>0</posx>
                                <posy>0</posy>
                                <width>215</width>
                                <height>30</height>
                                <font>font10</font>
                                <align>center</align>
                                <textcolor>FFFFFFFF</textcolor>
                                <label>$INFO[ListItem.Label]</label>
                            </control>
                            <control type="label">
                                <posx>0</posx>
                                <posy>30</posy>
                                <width>215</width>
                                <height>30</height>
                                <font>font10</font>
                                <align>center</align>
                                <textcolor>FFFFFFFF</textcolor>
                                <label>$INFO[ListItem.Property(year)]</label>
                            </control>
                        </control>
                    </control>
                </control>
            </itemlayout>

            <!-- FOCUSED LAYOUT ####################################### -->
            <focusedlayout width="260">
                <control type="group">
                    <posx>60</posx>
                    <posy>60</posy>
                    <control type="group">
                        <animation effect="zoom" start="100" end="110" time="100" center="107.5,107.5" reversible="false">Focus</animation>
                        <animation effect="zoom" start="110" end="100" time="100" center="107.5,107.5" reversible="false">UnFocus</animation>
                        <control type="group">
                            <posx>0</posx>
                            <posy>0</posy>
                            <control type="image">
                                <visible>Control.HasFocus(400)</visible>
                                <posx>-40</posx>
                                <posy>-40</posy>
                                <width>295</width>
                                <height>295</height>
                                <texture border="40">script.plex/square-rounded-shadow.png</texture>
                            </control>
                            <control type="image">
                                <posx>0</posx>
                                <posy>0</posy>
                                <width>215</width>
                                <height>215</height>
                                <texture>$INFO[ListItem.Property(thumb.fallback)]</texture>
                            </control>
                            <control type="image">
                                <posx>0</posx>
                                <posy>0</posy>
                                <width>215</width>
                                <height>215</height>
                                <texture background="true">$INFO[ListItem.Thumb]</texture>
                                <aspectratio>scale</aspectratio>
                            </control>
                            <control type="group">
                                <posx>0</posx>
                                <posy>220</posy>
                                <control type="label">
                                    <scroll>false</scroll>
                                    <posx>0</posx>
                                    <posy>0</posy>
                                    <width>215</width>
                                    <height>30</height>
                                    <font>font10</font>
                                    <align>center</align>
                                    <textcolor>FFFFFFFF</textcolor>
                                    <label>$INFO[ListItem.Label]</label>
                                </control>
                                <control type="label">
                                    <posx>0</posx>
                                    <posy>30</posy>
                                    <width>215</width>
                                    <height>30</height>
                                    <font>font10</font>
                                    <align>center</align>
                                    <textcolor>FFFFFFFF</textcolor>
                                    <label>$INFO[ListItem.Property(year)]</label>
                                </control>
                            </control>
                        </control>
                        <control type="image">
                            <visible>Control.HasFocus(400)</visible>
                            <posx>-5</posx>
                            <posy>-5</posy>
                            <width>225</width>
                            <height>225</height>
                            <texture border="10">script.plex/home/selected.png</texture>
                        </control>
                    </control>
                </control>
            </focusedlayout>
        </control>
    </control>

    <!-- similar artists -->
    <control type="group" id="500">
        <visible>Integer.IsGreater(Container(401).NumItems,0) + String.IsEmpty(Window.Property(drawing))</visible>
        <defaultcontrol>401</defaultcontrol>
        <width>1920</width>
        <height>520</height>
        <posx>0</posx>
        <posy>945</posy>
        <control type="image">
            <visible>!String.IsEmpty(Window.Property(divider.401))</visible>
            <posx>60</posx>
            <posy>0</posy>
            <width>1800</width>
            <height>2</height>
            <texture>script.plex/white-square.png</texture>
            <colordiffuse>A0000000</colordiffuse>
        </control>
        <control type="label">
            <posx>60</posx>
            <posy>0</posy>
            <width>1000</width>
            <height>80</height>
            <font>font12</font>
            <align>left</align>
            <aligny>center</aligny>
            <textcolor>FFFFFFFF</textcolor>
            <label>[UPPERCASE]$INFO[Window.Property(related.header)][/UPPERCASE]</label>
        </control>
        <control type="list" id="401">
            <posx>0</posx>
            <posy>16</posy>
            <width>1920</width>
            <height>520</height>
            <onup>400</onup>
            <ondown>false</ondown>
            <onleft>false</onleft>
            <onright>false</onright>
            <scrolltime>200</scrolltime>
            <orientation>horizontal</orientation>
            <preloaditems>4</preloaditems>
            <!-- ITEM LAYOUT ########################################## -->
            <itemlayout width="260">
                <control type="group">
                    <posx>60</posx>
                    <posy>60</posy>
                    <control type="group">
                        <posx>0</posx>
                        <posy>0</posy>
                        <control type="image">
                            <posx>0</posx>
                            <posy>0</posy>
                            <width>215</width>
                            <height>215</height>
                            <texture>$INFO[ListItem.Property(thumb.fallback)]</texture>
                        </control>
                        <control type="image">
                            <posx>0</posx>
                            <posy>0</posy>
                            <width>215</width>
                            <height>215</height>
                            <texture background="true">$INFO[ListItem.Thumb]</texture>
                            <aspectratio>scale</aspectratio>
                        </control>
                        <control type="group">
                            <posx>0</posx>
                            <posy>220</posy>
                            <control type="label">
                                <posx>0</posx>
                                <posy>0</posy>
                                <width>215</width>
                                <height>30</height>
                                <font>font10</font>
                                <align>center</align>
                                <textcolor>FFFFFFFF</textcolor>
                                <label>$INFO[ListItem.Label]</label>
                            </control>
                            <control type="label">
                                <posx>0</posx>
                                <posy>30</posy>
                                <width>215</width>
                                <height>30</height>
                                <font>font10</font>
                                <align>center</align>
                                <textcolor>FFFFFFFF</textcolor>
                                <label>$INFO[ListItem.Property(year)]</label>
                            </control>
                        </control>
                        <control type="group">
                            <visible>!String.IsEmpty(ListItem.Property(is.boundary))</visible>
                            <control type="image">
                                <posx>0</posx>
                                <posy>0</posy>
                                <width>215</width>
                                <height>215</height>
                                <texture colordiffuse="FF404040">script.plex/white-square.png</texture>
                            </control>
                            <control type="image">
                                <visible>String.IsEmpty(ListItem.Property(is.updating)) + !String.IsEmpty(ListItem.Property(right.boundary))</visible>
                                <posx>77</posx>
                                <posy>57.5</posy>
                                <width>61</width>
                                <height>100</height>
                                <texture colordiffuse="40000000">script.plex/indicators/chevron-white.png</texture>
                            </control>
                            <control type="image">
                                <visible>String.IsEmpty(ListItem.Property(is.updating)) + !String.IsEmpty(ListItem.Property(left.boundary))</visible>
                                <posx>77</posx>
                                <posy>57.5</posy>
                                <width>61</width>
                                <height>100</height>
                                <texture colordiffuse="40000000">script.plex/indicators/chevron-white-l.png</texture>
                            </control>
                            <control type="image">
                                <visible>!String.IsEmpty(ListItem.Property(is.updating))</visible>
                                <posx>43.5</posx>
                                <posy>43.5</posy>
                                <width>128</width>
                                <height>128</height>
                                <texture>script.plex/home/busy.gif</texture>
                            </control>
                        </control>
                    </control>
                </control>
            </itemlayout>

            <!-- FOCUSED LAYOUT ####################################### -->
            <focusedlayout width="260">
                <control type="group">
                    <posx>60</posx>
                    <posy>60</posy>
                    <control type="group">
                        <animation effect="zoom" start="100" end="110" time="100" center="107.5,107.5" reversible="false">Focus</animation>
                        <animation effect="zoom" start="110" end="100" time="100" center="107.5,107.5" reversible="false">UnFocus</animation>
                        <control type="group">
                            <posx>0</posx>
                            <posy>0</posy>
                            <control type="image">
                                <visible>Control.HasFocus(400)</visible>
                                <posx>-40</posx>
                                <posy>-40</posy>
                                <width>295</width>
                                <height>295</height>
                                <texture border="40">script.plex/square-rounded-shadow.png</texture>
                            </control>
                            <control type="image">
                                <posx>0</posx>
                                <posy>0</posy>
                                <width>215</width>
                                <height>215</height>
                                <texture>$INFO[ListItem.Property(thumb.fallback)]</texture>
                            </control>
                            <control type="image">
                                <posx>0</posx>
                                <posy>0</posy>
                                <width>215</width>
                                <height>215</height>
                                <texture background="true">$INFO[ListItem.Thumb]</texture>
                                <aspectratio>scale</aspectratio>
                            </control>
                            <control type="group">
                                <posx>0</posx>
                                <posy>220</posy>
                                <control type="label">
                                    <scroll>false</scroll>
                                    <posx>0</posx>
                                    <posy>0</posy>
                                    <width>215</width>
                                    <height>30</height>
                                    <font>font10</font>
                                    <align>center</align>
                                    <textcolor>FFFFFFFF</textcolor>
                                    <label>$INFO[ListItem.Label]</label>
                                </control>
                                <control type="label">
                                    <posx>0</posx>
                                    <posy>30</posy>
                                    <width>215</width>
                                    <height>30</height>
                                    <font>font10</font>
                                    <align>center</align>
                                    <textcolor>FFFFFFFF</textcolor>
                                    <label>$INFO[ListItem.Property(year)]</label>
                                </control>
                            </control>
                        </control>
                        <control type="image">
                            <visible>Control.HasFocus(401)</visible>
                            <posx>-5</posx>
                            <posy>-5</posy>
                            <width>225</width>
                            <height>225</height>
                            <texture border="10">script.plex/home/selected.png</texture>
                        </control>
                        <control type="group">
                            <visible>!String.IsEmpty(ListItem.Property(is.boundary))</visible>
                            <control type="image">
                                <posx>0</posx>
                                <posy>0</posy>
                                <width>215</width>
                                <height>215</height>
                                <texture colordiffuse="FF404040">script.plex/white-square.png</texture>
                            </control>
                            <control type="image">
                                <visible>String.IsEmpty(ListItem.Property(is.updating)) + !String.IsEmpty(ListItem.Property(right.boundary))</visible>
                                <posx>77</posx>
                                <posy>57.5</posy>
                                <width>61</width>
                                <height>100</height>
                                <texture colordiffuse="40000000">script.plex/indicators/chevron-white.png</texture>
                            </control>
                            <control type="image">
                                <visible>String.IsEmpty(ListItem.Property(is.updating)) + !String.IsEmpty(ListItem.Property(left.boundary))</visible>
                                <posx>77</posx>
                                <posy>57.5</posy>
                                <width>61</width>
                                <height>100</height>
                                <texture colordiffuse="40000000">script.plex/indicators/chevron-white-l.png</texture>
                            </control>
                            <control type="image">
                                <visible>!String.IsEmpty(ListItem.Property(is.updating))</visible>
                                <posx>43.5</posx>
                                <posy>43.5</posy>
                                <width>128</width>
                                <height>128</height>
                                <texture>script.plex/home/busy.gif</texture>
                            </control>
                        </control>
                    </control>
                </control>
            </focusedlayout>
        </control>
    </control>
</control>
{% endblock content %}