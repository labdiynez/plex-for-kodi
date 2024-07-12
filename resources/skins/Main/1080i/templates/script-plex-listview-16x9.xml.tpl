{% extends "library.xml.tpl" %}
{% block header_bg %}{% endblock %}
{% block header_animation %}{% endblock %}
{% block filteropts_grouplist_attrs %} id="600"{% endblock %}
{% block no_content %}{% endblock %}

{% block content %}
<control type="group">
    <posx>60</posx>
    <posy>248</posy>
    <control type="image">
        <visible>!String.IsEqual(Window.Property(media),show) + !String.IsEqual(Window.Property(media),movie)</visible>
        <posx>0</posx>
        <posy>0</posy>
        <width>630</width>
        <height>355</height>
        <fadetime>500</fadetime>
        <texture background="true" fallback="script.plex/thumb_fallbacks/movie.png">$INFO[Container(101).ListItem.Property(art)]</texture>
        <aspectratio>scale</aspectratio>
    </control>
    <control type="image">
        <visible>String.IsEqual(Window.Property(media),show) | String.IsEqual(Window.Property(media),movie)</visible>
        <posx>0</posx>
        <posy>0</posy>
        <width>630</width>
        <height>355</height>
        <fadetime>500</fadetime>
        <texture background="true" fallback="script.plex/thumb_fallbacks/show.png">$INFO[Container(101).ListItem.Property(art)]</texture>
        <aspectratio>scale</aspectratio>
    </control>
    <control type="label">
        <posx>0</posx>
        <posy>355</posy>
        <width>440</width>
        <height>80</height>
        <font>font12</font>
        <align>left</align>
        <aligny>center</aligny>
        <textcolor>FFFFFFFF</textcolor>
        <label>[B]$INFO[Container(101).ListItem.Label][/B]</label>
    </control>
    <control type="label">
        <posx>630</posx>
        <posy>355</posy>
        <width>180</width>
        <height>80</height>
        <font>font12</font>
        <align>right</align>
        <aligny>center</aligny>
        <textcolor>FFFFFFFF</textcolor>
        <label>[B]$INFO[Container(101).ListItem.Label2][/B]</label>
    </control>
    <control type="image">
        <posx>0</posx>
        <posy>435</posy>
        <width>630</width>
        <height>2</height>
        <texture>script.plex/white-square.png</texture>
        <colordiffuse>40000000</colordiffuse>
    </control>
    <control type="textbox">
        <posx>0</posx>
        <posy>463</posy>
        <width>630</width>
        <height>307</height>
        <font>font12</font>
        <align>left</align>
        <textcolor>FFDDDDDD</textcolor>
        <label>$INFO[Container(101).ListItem.Property(summary)]</label>
    </control>
</control>

<control type="group" id="50">
    <posx>0</posx>
    <posy>135</posy>
    <defaultcontrol>101</defaultcontrol>

    {% block buttons %}
        <control type="grouplist" id="300">
            <animation effect="fade" start="0" end="100" time="200" reversible="true">VisibleChange</animation>
            <defaultcontrol>301</defaultcontrol>
            <posx>30</posx>
            <posy>-25</posy>
            <width>1000</width>
            <height>145</height>
            <onup>200</onup>
            <ondown>101</ondown>
            <onright>101</onright>
            <itemgap>-20</itemgap>
            <orientation>horizontal</orientation>
            <scrolltime tween="quadratic" easing="out">200</scrolltime>
            <usecontrolcoords>true</usecontrolcoords>
            <visible>!String.IsEmpty(Window.Property(initialized))</visible>

            {% with attr = {"width": 126, "height": 100} & template = "includes/themed_button.xml.tpl" & hitrect = {"x": 20, "y": 20, "w": 86, "h": 60} %}
                {% include template with name="play" & id=301 & visible="!String.IsEqual(Window(10000).Property(script.plex.item.type),collection) | String.IsEqual(Window.Property(media),collection)" %}
                {% include template with name="shuffle" & id=302 & visible="!String.IsEqual(Window(10000).Property(script.plex.item.type),collection) | String.IsEqual(Window.Property(media),collection)" %}
                {% include template with name="more" & id=303 & visible="String.IsEmpty(Window.Property(no.options)) | Player.HasAudio" %}
                {% include template with name="chapters" & id=304 %}
            {% endwith %}

        </control>
    {% endblock %}

    <control type="group" id="100">
        <visible>Integer.IsGreater(Container(101).NumItems,0) + String.IsEmpty(Window.Property(drawing))</visible>
        <defaultcontrol>101</defaultcontrol>
        <posx>750</posx>
        <posy>0</posy>
        <width>1170</width>
        <height>1080</height>
        <control type="image">
            <posx>0</posx>
            <posy>0</posy>
            <width>1170</width>
            <height>1080</height>
            <texture>script.plex/white-square.png</texture>
            <colordiffuse>20000000</colordiffuse>
        </control>
        <control type="list" id="101">
            <hitrect x="60" y="0" w="1010" h="945" />
            <posx>0</posx>
            <posy>0</posy>
            <width>1170</width>
            <height>945</height>
            <onup>600</onup>
            <onright>151</onright>
            <onleft>304</onleft>
            <scrolltime>200</scrolltime>
            <orientation>vertical</orientation>
            <preloaditems>4</preloaditems>
            <pagecontrol>152</pagecontrol>
            <!-- ITEM LAYOUT ########################################## -->
            <itemlayout height="76">
                <control type="group">
                    <posx>120</posx>
                    <posy>24</posy>
                    <control type="group">
                        <control type="image">
                            <visible>String.IsEmpty(ListItem.Property(use_alt_watched)) + !String.IsEmpty(ListItem.Property(unwatched)) + String.IsEmpty(ListItem.Property(watched))</visible>
                            <posx>880</posx>
                            <posy>-3</posy>
                            <width>35</width>
                            <height>35</height>
                            <texture fallback="script.plex/indicators/unwatched.png">special://profile/addon_data/script.plexmod/media/unwatched.png</texture>
                        </control>
                        <control type="group">
                            <visible>!String.IsEmpty(Window.Property(use_alt_watched)) + !String.IsEmpty(ListItem.Property(initialized)) + String.IsEmpty(ListItem.Property(unwatched)) + String.IsEmpty(.ListItem.Property(unwatched.count)) + String.IsEmpty(ListItem.Property(progress))</visible>
                            <posx>895</posx>
                            <posy>0</posy>
                            <control type="image">
                                <posx>0</posx>
                                <posy>8</posy>
                                <width>16</width>
                                <height>16</height>
                                <texture fallback="script.plex/indicators/watched.png">special://profile/addon_data/script.plexmod/media/watched.png</texture>
                            </control>
                        </control>
                        <control type="group">
                            <visible>!String.IsEmpty(ListItem.Property(unwatched.count))</visible>
                            <posx>861</posx>
                            <posy>14</posy>
                            <control type="image">
                                <posx>0</posx>
                                <posy>0</posy>
                                <width>54</width>
                                <height>42</height>
                                <texture colordiffuse="FFCC7B19">script.plex/white-square-rounded.png</texture>
                            </control>
                            <control type="label">
                                <posx>0</posx>
                                <posy>0</posy>
                                <width>54</width>
                                <height>42</height>
                                <font>font10</font>
                                <align>center</align>
                                <aligny>center</aligny>
                                <textcolor>FF000000</textcolor>
                                <label>$INFO[ListItem.Property(unwatched.count)]</label>
                            </control>
                        </control>
                        <control type="group">
                            <posx>0</posx>
                            <posy>0</posy>
                            <control type="label">
                                <posx>0</posx>
                                <posy>0</posy>
                                <width>915</width>
                                <height>72</height>
                                <font>font10</font>
                                <align>left</align>
                                <textcolor>FFFFFFFF</textcolor>
                                <label>[B]$INFO[ListItem.Label][/B]</label>
                            </control>
                            <control type="label">
                                <visible>!String.IsEmpty(ListItem.Property(year))</visible>
                                <posx>0</posx>
                                <posy>30</posy>
                                <width>915</width>
                                <height>72</height>
                                <font>font10</font>
                                <align>left</align>
                                <textcolor>FFFFFFFF</textcolor>
                                <label>[B]$INFO[ListItem.Property(year)][/B]</label>
                            </control>
                        </control>
                    </control>
                    <control type="image">
                        <visible>String.IsEmpty(ListItem.Property(is.footer))</visible>
                        <posx>0</posx>
                        <posy>72</posy>
                        <width>915</width>
                        <height>2</height>
                        <texture>script.plex/white-square.png</texture>
                        <colordiffuse>40000000</colordiffuse>
                    </control>
                </control>
            </itemlayout>

            <!-- FOCUSED LAYOUT ####################################### -->
            <focusedlayout height="76">
                <control type="group">
                    <control type="group">
                        <visible>!Control.HasFocus(101)</visible>
                        <posx>120</posx>
                        <posy>24</posy>
                        <control type="group">
                            <control type="image">
                                <visible>String.IsEmpty(ListItem.Property(use_alt_watched)) + !String.IsEmpty(ListItem.Property(unwatched)) + String.IsEmpty(ListItem.Property(watched))</visible>
                                <posx>880</posx>
                                <posy>-2</posy>
                                <width>35</width>
                                <height>35</height>
                                <texture fallback="script.plex/indicators/unwatched.png">special://profile/addon_data/script.plexmod/media/unwatched.png</texture>
                            </control>
                            <control type="group">
                                <visible>!String.IsEmpty(Window.Property(use_alt_watched)) + !String.IsEmpty(ListItem.Property(initialized)) + String.IsEmpty(ListItem.Property(unwatched)) + String.IsEmpty(ListItem.Property(unwatched.count)) + String.IsEmpty(ListItem.Property(progress))</visible>
                                <posx>895</posx>
                                <posy>0</posy>
                                <control type="image">
                                    <posx>0</posx>
                                    <posy>8</posy>
                                    <width>16</width>
                                    <height>16</height>
                                    <texture fallback="script.plex/indicators/watched.png">special://profile/addon_data/script.plexmod/media/watched.png</texture>
                                </control>
                            </control>
                            <control type="group">
                                <visible>!String.IsEmpty(ListItem.Property(unwatched.count))</visible>
                                <posx>861</posx>
                                <posy>14</posy>
                                <control type="image">
                                    <posx>0</posx>
                                    <posy>0</posy>
                                    <width>54</width>
                                    <height>42</height>
                                    <texture colordiffuse="FFCC7B19">script.plex/white-square-rounded.png</texture>
                                </control>
                                <control type="label">
                                    <posx>0</posx>
                                    <posy>0</posy>
                                    <width>54</width>
                                    <height>42</height>
                                    <font>font10</font>
                                    <align>center</align>
                                    <aligny>center</aligny>
                                    <textcolor>FF000000</textcolor>
                                    <label>$INFO[ListItem.Property(unwatched.count)]</label>
                                </control>
                            </control>
                            <control type="group">
                                <posx>0</posx>
                                <posy>0</posy>
                                <control type="label">
                                    <posx>0</posx>
                                    <posy>0</posy>
                                    <width>915</width>
                                    <height>72</height>
                                    <font>font10</font>
                                    <align>left</align>
                                    <textcolor>FFFFFFFF</textcolor>
                                    <label>[B]$INFO[ListItem.Label][/B]</label>
                                </control>
                                <control type="label">
                                    <visible>!String.IsEmpty(ListItem.Property(year))</visible>
                                    <posx>0</posx>
                                    <posy>30</posy>
                                    <width>915</width>
                                    <height>72</height>
                                    <font>font10</font>
                                    <align>left</align>
                                    <textcolor>FFFFFFFF</textcolor>
                                    <label>[B]$INFO[ListItem.Property(year)][/B]</label>
                                </control>
                            </control>
                        </control>
                        <control type="image">
                            <visible>String.IsEmpty(ListItem.Property(is.footer))</visible>
                            <posx>0</posx>
                            <posy>72</posy>
                            <width>915</width>
                            <height>2</height>
                            <texture>script.plex/white-square.png</texture>
                            <colordiffuse>40000000</colordiffuse>
                        </control>
                    </control>

                    <control type="group">
                        <visible>Control.HasFocus(101)</visible>
                        <posx>63</posx>
                        <posy>21</posy>
                        <control type="image">
                            <posx>-40</posx>
                            <posy>-40</posy>
                            <width>1085</width>
                            <height>156</height>
                            <texture border="40">script.plex/square-rounded-shadow.png</texture>
                        </control>
                        <control type="image">
                            <posx>0</posx>
                            <posy>0</posy>
                            <width>1005</width>
                            <height>76</height>
                            <texture border="12">script.plex/white-square-rounded.png</texture>
                            <colordiffuse>FFE5A00D</colordiffuse>
                        </control>

                        <control type="group">
                            <control type="image">
                                <visible>String.IsEmpty(ListItem.Property(use_alt_watched)) + !String.IsEmpty(ListItem.Property(unwatched)) + String.IsEmpty(ListItem.Property(watched))</visible>
                                <posx>957</posx>
                                <posy>0</posy>
                                <width>48</width>
                                <height>48</height>
                                <texture fallback="script.plex/indicators/unwatched-rounded.png">special://profile/addon_data/script.plexmod/media/unwatched-rounded.png</texture>
                            </control>
                            <control type="group">
                                <visible>!String.IsEmpty(ListItem.Property(use_alt_watched)) + !String.IsEmpty(ListItem.Property(watched))</visible>
                                <posx>951</posx>
                                <posy>8</posy>
                                <control type="image">
                                    <posx>0</posx>
                                    <posy>8</posy>
                                    <width>16</width>
                                    <height>16</height>
                                    <texture fallback="script.plex/indicators/watched.png">special://profile/addon_data/script.plexmod/media/watched.png</texture>
                                </control>
                            </control>
                            <control type="group">
                                <visible>!String.IsEmpty(ListItem.Property(unwatched.count))</visible>
                                <posx>933</posx>
                                <posy>15</posy>
                                <control type="image">
                                    <visible>!String.IsEmpty(ListItem.Property(unwatched.count))</visible>
                                    <posx>0</posx>
                                    <posy>0</posy>
                                    <width>57</width>
                                    <height>46</height>
                                    <texture colordiffuse="FFCC7B19">script.plex/white-square-rounded.png</texture>
                                </control>
                                <control type="label">
                                    <posx>0</posx>
                                    <posy>0</posy>
                                    <width>57</width>
                                    <height>46</height>
                                    <font>font10</font>
                                    <align>center</align>
                                    <aligny>center</aligny>
                                    <textcolor>FF000000</textcolor>
                                    <label>$INFO[ListItem.Property(unwatched.count)]</label>
                                </control>
                            </control>
                            <control type="group">
                                <posx>60</posx>
                                <posy>4</posy>
                                <control type="label">
                                    <posx>0</posx>
                                    <posy>0</posy>
                                    <width>510</width>
                                    <height>72</height>
                                    <font>font12</font>
                                    <align>left</align>
                                    <textcolor>DF000000</textcolor>
                                    <label>[B]$INFO[ListItem.Label][/B]</label>
                                </control>
                                <control type="label">
                                    <visible>!String.IsEmpty(ListItem.Property(year))</visible>
                                    <posx>0</posx>
                                    <posy>30</posy>
                                    <width>510</width>
                                    <height>72</height>
                                    <font>font12</font>
                                    <align>left</align>
                                    <textcolor>DF000000</textcolor>
                                    <label>[B]$INFO[ListItem.Property(year)][/B]</label>
                                </control>
                            </control>
                        </control>
                    </control>
                </control>
            </focusedlayout>
        </control>

        <control type="scrollbar" id="152">
            <hitrect x="1108" y="33" w="90" h="879" />
            <left>1128</left>
            <top>33</top>
            <width>10</width>
            <height>879</height>
            <onleft>101</onleft>
            <visible>true</visible>
            <texturesliderbackground colordiffuse="40000000" border="5">script.plex/white-square-rounded.png</texturesliderbackground>
            <texturesliderbar colordiffuse="77FFFFFF" border="5">script.plex/white-square-rounded.png</texturesliderbar>
            <texturesliderbarfocus colordiffuse="FFE5A00D" border="5">script.plex/white-square-rounded.png</texturesliderbarfocus>
            <textureslidernib>-</textureslidernib>
            <textureslidernibfocus>-</textureslidernibfocus>
            <pulseonselect>false</pulseonselect>
            <orientation>vertical</orientation>
            <showonepage>false</showonepage>
            <onleft>151</onleft>
        </control>
    </control>
</control>

<control type="group" id="150">
    <visible>String.IsEqual(Window(10000).Property(script.plex.sort),titleSort) + Integer.IsGreater(Container(101).NumItems,0) + String.IsEmpty(Window.Property(drawing))</visible>
    <defaultcontrol>151</defaultcontrol>
    <posx>1830</posx>
    <posy>150</posy>
    <width>20</width>
    <height>920</height>
    <control type="list" id="151">
        <posx>0</posx>
        <posy>0</posy>
        <width>34</width>
        <height>1050</height>
        <onleft>100</onleft>
        <onright>152</onright>
        <scrolltime>200</scrolltime>
        <orientation>vertical</orientation>
        <!-- ITEM LAYOUT ########################################## -->
        <itemlayout height="34">
            <control type="group">
                <posx>0</posx>
                <posy>0</posy>
                <control type="group">
                    <posx>0</posx>
                    <posy>0</posy>
                    <control type="label">
                        <visible>!String.IsEqual(Window(10000).Property(script.plex.key), ListItem.Property(letter))</visible>
                        <posx>0</posx>
                        <posy>0</posy>
                        <width>34</width>
                        <height>32</height>
                        <font>font10</font>
                        <align>center</align>
                        <aligny>center</aligny>
                        <textcolor>99FFFFFF</textcolor>
                        <label>$INFO[ListItem.Label]</label>
                    </control>
                    <control type="label">
                        <visible>String.IsEqual(Window(10000).Property(script.plex.key), ListItem.Property(key))</visible>
                        <posx>0</posx>
                        <posy>0</posy>
                        <width>34</width>
                        <height>32</height>
                        <font>font10</font>
                        <align>center</align>
                        <aligny>center</aligny>
                        <textcolor>FFE5A00D</textcolor>
                        <label>$INFO[ListItem.Label]</label>
                    </control>
                </control>
            </control>
        </itemlayout>

        <!-- FOCUSED LAYOUT ####################################### -->
        <focusedlayout height="34">
            <control type="group">
                <posx>0</posx>
                <posy>0</posy>
                <control type="group">
                    <posx>0</posx>
                    <posy>0</posy>
                    <control type="label">
                        <visible>!String.IsEqual(Window(10000).Property(script.plex.key), ListItem.Property(letter))</visible>
                        <posx>0</posx>
                        <posy>0</posy>
                        <width>34</width>
                        <height>32</height>
                        <font>font10</font>
                        <align>center</align>
                        <aligny>center</aligny>
                        <textcolor>99FFFFFF</textcolor>
                        <label>$INFO[ListItem.Label]</label>
                    </control>
                    <control type="label">
                        <visible>String.IsEqual(Window(10000).Property(script.plex.key), ListItem.Property(key))</visible>
                        <posx>0</posx>
                        <posy>0</posy>
                        <width>34</width>
                        <height>32</height>
                        <font>font10</font>
                        <align>center</align>
                        <aligny>center</aligny>
                        <textcolor>FFE5A00D</textcolor>
                        <label>$INFO[ListItem.Label]</label>
                    </control>
                </control>

                <control type="group">
                    <visible>Control.HasFocus(151)</visible>
                    <posx>0</posx>
                    <posy>0</posy>
                    <control type="image">
                        <visible>Control.HasFocus(151)</visible>
                        <posx>0</posx>
                        <posy>0</posy>
                        <width>34</width>
                        <height>34</height>
                        <colordiffuse>FFE5A00D</colordiffuse>
                        <texture border="12">script.plex/white-outline-rounded.png</texture>
                    </control>
                </control>
            </control>
        </focusedlayout>
    </control>
</control>
{% endblock content %}