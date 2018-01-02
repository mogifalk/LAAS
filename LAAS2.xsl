<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output
            method="html"
            encoding="UTF-8"
            doctype-public="-//W3C//DTD HTML 4.01//EN"
            doctype-system="http://www.w3.org/TR/html4/strict.dtd"
            indent="yes" />

    <xsl:template match="/">

        <html>
            <head>
                <title>Données LAAS</title>
                <link rel="stylesheet" href="LAAS2.css"/>
            </head>

            <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

            <body>
                <h1>Bienvenue sur la base de données du LAAS</h1>

                <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

                <h2>Liste des membres du LAAS : </h2>
                <xsl:for-each select="LAAS/Membres/Membre">
                    <xsl:sort  select="nom_membre"></xsl:sort>
                    <p>
                        <span class="blue">Nom : </span>
                        <xsl:value-of select="nom_membre" />
                        <br/>
                        
                        <span class="blue">Prénom : </span>
                        <xsl:value-of select="prenom_membre" />
                        <br/>
                        
                        <span class="blue">id : </span>
                        <xsl:value-of select="id_membre" />
                    </p>
                </xsl:for-each>

                <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

                <h2>Liste des équipes du LAAS : </h2>
                <xsl:for-each select="LAAS/Equipe">
                    <xsl:variable name="acro_equipe_current" select="acronyme_equipe"/>
                    <xsl:variable name="acro_theme_equipe" select="acronyme_theme"/>
                    <p>
                        <span class="blue"> Nom de l'équipe : </span>
                        <xsl:value-of select="nom_equipe"/>
                        <br/>
                        
                        <span class="blue">Acronyme : </span>
                        <xsl:value-of select="acronyme_equipe" />
                        <br/>
                        
                        <span class="blue">Thème de recherche : </span>
                        <xsl:for-each select="/LAAS/Theme">
                            <xsl:if test="acronyme_theme=$acro_theme_equipe">
                                <xsl:value-of select="description"/>
                            </xsl:if>
                        </xsl:for-each>
                        <br/>
                        
                        <span class="blue">Membres de l'équipe : </span> <br/>
                        <xsl:for-each select="/LAAS/Membres/Membre">
                            <xsl:sort  select="nom_membre"></xsl:sort>
                            <xsl:if test="acronyme_equipe=$acro_equipe_current">
                                <span class="simple_indent"><xsl:value-of select="nom_membre"/>&#160;<xsl:value-of select="prenom_membre"/></span>
                                <br/>
                            </xsl:if>
                        </xsl:for-each>
                    </p>
                </xsl:for-each>

                <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

                <h2>Liste des thèses : </h2>

                <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

                <h3>Thèses en cours de réalisation :</h3>
                <xsl:for-each select="LAAS/En_Cours">
                    <xsl:sort  select="titre_these"></xsl:sort>
                    <xsl:variable name="acro_equipe_cadre" select="acronyme_equipe"/>
                    <p class="simple_indent">
                        <span class="blue">Titre de la thèse : </span>
                        <xsl:value-of select="titre_these"/>
                        <br/>

                        <span class="blue">Domaine :  </span>
                        <xsl:value-of select="domaine" />
                        <br/>

                        <span class="blue">Date de début : </span>
                        <xsl:value-of select="date_debut" />
                        <br/>
                        
                        <span class="blue">Equipe encadrante : </span>
                        <xsl:for-each select="/LAAS/Equipe">
                            <xsl:if test="acronyme_equipe=$acro_equipe_cadre">
                                <xsl:value-of select="nom_equipe" />
                            </xsl:if>
                        </xsl:for-each>
                        <br/>

                        <span class="blue">Encadrant(s) : </span>
                        <br/>

                        <xsl:for-each select="Membres_contenus">
                        <xsl:variable name="id_encadrant_current" select="@id_membre"/>

                            <xsl:for-each select="/LAAS/Membres/Membre">
                                <xsl:sort  select="nom_membre"></xsl:sort>
                                <xsl:if test="id_membre=$id_encadrant_current">
                                    <span class="double_indent">
                                        <xsl:value-of select="nom_membre"/>&#160;<xsl:value-of select="prenom_membre"/>
                                    </span>
                                    <br/>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:for-each>

                        <span class="blue">Productions associées :</span>
                        <br/>

                        <xsl:for-each select="Rapports_Recherche">
                            <xsl:variable name="rapport_current" select="@titre_rapport"/>

                            <xsl:for-each select="/LAAS/Projet_de_Recherche/Rapport_Recherche">
                                <xsl:sort  select="nom_rapport_recherche"></xsl:sort>
                                <xsl:if test="nom_rapport_recherche=$rapport_current">
                                    <span class="double_indent" color="steelblue">
                                        <xsl:value-of select="nom_rapport_recherche"/> (<em>rapport de recherche</em>)
                                    </span>
                                    <br/>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:for-each>

                        <xsl:for-each select="Revues">
                            <xsl:variable name="revue_current" select="@titre_revue"/>

                            <xsl:for-each select="/LAAS/Revue">
                                <xsl:sort  select="nom_journal"></xsl:sort>
                                <xsl:if test="nom_journal=$revue_current">
                                    <span class="double_indent" color="steelblue">
                                        <xsl:value-of select="nom_journal"/> (<em>revue scientifique</em>)
                                    </span>
                                    <br/>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:for-each>

                        <xsl:for-each select="Articles_Conf">
                            <xsl:variable name="article_current" select="@titre_article"/>

                            <xsl:for-each select="/LAAS/Article_Conference">
                                <xsl:sort  select="nom_conf"></xsl:sort>
                                <xsl:if test="nom_conf=$article_current">
                                    <span class="double_indent" color="steelblue">
                                        <xsl:value-of select="nom_conf"/> (<em>article de conférence</em>)
                                    </span>
                                    <br/>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:for-each>
                    </p>
                </xsl:for-each>

                <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

                <h3>Thèses soutenues :</h3>
                <xsl:for-each select="LAAS/Soutenue">
                    <xsl:sort  select="titre_these"></xsl:sort>
                    <xsl:variable name="acro_equipe_cadre" select="acronyme_equipe"/>
                    <p class="simple_indent">
                        <span class="blue">Titre de la thèse : </span>
                        <xsl:value-of select="titre_these"/>
                        <br/>

                        <span class="blue">Domaine :  </span>
                        <xsl:value-of select="domaine" />
                        <br/>

                        <span class="blue">Date début - date fin : </span>
                        <xsl:value-of select="date_debut" /> - <xsl:value-of select="date_fin"/>
                        <br/>

                        <span class="blue">Equipe encadrante : </span>
                        <xsl:for-each select="/LAAS/Equipe">
                            <xsl:if test="acronyme_equipe=$acro_equipe_cadre">
                                <xsl:value-of select="nom_equipe" />
                            </xsl:if>
                        </xsl:for-each>
                        <br/>

                        <span class="blue">Encadrant(s) : </span>
                        <br/>
                        <xsl:for-each select="Membres_contenus">
                            <xsl:variable name="id_encadrant_current" select="@id_membre"/>

                            <xsl:for-each select="/LAAS/Membres/Membre">
                                <xsl:sort  select="nom_membre"></xsl:sort>
                                <xsl:if test="id_membre=$id_encadrant_current">
                                    <span class="double_indent">
                                        <xsl:value-of select="nom_membre"/>&#160;<xsl:value-of select="prenom_membre"/>
                                    </span>
                                    <br/>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:for-each>

                        <span class="blue">Productions associées :</span>
                        <br/>
                        <xsl:for-each select="Rapports_Recherche">
                            <xsl:variable name="rapport_current" select="@titre_rapport"/>

                            <xsl:for-each select="/LAAS/Projet_de_Recherche/Rapport_Recherche">
                                <xsl:sort  select="nom_rapport_recherche"></xsl:sort>
                                <xsl:if test="nom_rapport_recherche=$rapport_current">
                                    <span class="double_indent" color="steelblue">
                                        <xsl:value-of select="nom_rapport_recherche"/> (<em>rapport de recherche</em>)
                                    </span>
                                    <br/>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:for-each>

                        <xsl:for-each select="Revues">
                            <xsl:variable name="revue_current" select="@titre_revue"/>

                            <xsl:for-each select="/LAAS/Revue">
                                <xsl:sort  select="nom_journal"></xsl:sort>
                                <xsl:if test="nom_journal=$revue_current">
                                    <span class="double_indent" color="steelblue">
                                        <xsl:value-of select="nom_journal"/> (<em>revue scientifique</em>)
                                    </span>
                                    <br/>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:for-each>

                        <xsl:for-each select="Articles_Conf">
                            <xsl:variable name="article_current" select="@titre_article"/>

                            <xsl:for-each select="/LAAS/Article_Conference">
                                <xsl:sort  select="nom_conf"></xsl:sort>
                                <xsl:if test="nom_conf=$article_current">
                                    <span class="double_indent" color="steelblue">
                                        <xsl:value-of select="nom_conf"/> (<em>article de conférence</em>)
                                    </span>
                                    <br/>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:for-each>
                    </p>
                </xsl:for-each>

                <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

                <h2></h2>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>