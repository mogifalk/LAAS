<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

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

                <h2>Membres du LAAS : </h2>
                <xsl:for-each select="LAAS/Membres/Membre">
                    <xsl:sort  select="nom_membre"/>
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

                <h2>Equipes du LAAS : </h2>
                <xsl:for-each select="LAAS/Equipe">
                    <xsl:sort select="nom_equipe"/>
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
                            <xsl:sort  select="nom_membre"/>
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
                    <xsl:sort  select="titre_these"/>
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
                                <xsl:sort  select="nom_membre"/>
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
                                <xsl:sort  select="nom_rapport_recherche"/>
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
                                <xsl:sort  select="nom_journal"/>
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
                                <xsl:sort  select="nom_conf"/>
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
                    <xsl:sort select="titre_these"/>
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
                                <xsl:sort  select="nom_membre"/>
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
                                <xsl:sort  select="nom_rapport_recherche"/>
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
                                <xsl:sort  select="nom_journal"/>
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
                                <xsl:sort  select="nom_conf"/>
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

                <h2>Auteurs liés au LAAS : </h2>
                <xsl:for-each select="LAAS/Auteur">
                    <xsl:sort select="nom"/>
                    <p>
                        <span class="blue">Nom : </span>
                        <xsl:value-of select="nom"/>
                        <br/>

                        <span class="blue">id : </span>
                        <xsl:value-of select="id_auteur"/>
                        <br/>

                        <span class="blue">Affilitation : </span>
                        <xsl:value-of select="affiliation"/>
                        <br/>
                    </p>
                </xsl:for-each>

                <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

                <h2>Revues scientifiques : </h2>
                <xsl:for-each select="LAAS/Revue">
                    <xsl:sort select="nom_journal"/>
                    <p>
                        <span class="blue">Nom de la revue: </span>
                        <xsl:value-of select="nom_journal"/>
                        <br/>

                        <span class="blue">Année de publication : </span>
                        <xsl:value-of select="annee_publication"/>
                        <br/>

                        <span class="blue">Nombre de pages : </span>
                        <xsl:value-of select="nombre_pages"/>
                        <br/>

                        <span class="blue">Classe : </span>
                        <xsl:value-of select="classe"/>
                        <br/>

                        <span class="blue">Auteur(s) participant(s) : </span>
                        <br/>

                    <!-- recherche des auteurs externes associés -->
                    <xsl:for-each select="Auteur_production_externe">
                        <xsl:variable name="id_auteur_current" select="@id_auteur"/>

                        <xsl:for-each select="/LAAS/Auteur">
                            <xsl:sort  select="nom"/>
                            <xsl:if test="id_auteur=$id_auteur_current">
                                <span class="double_indent">
                                    <xsl:value-of select="nom"/>&#160;(<em>auteur externe</em>)
                                </span>
                                <br/>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:for-each>

                    <!-- recherche des auteurs du LAAS associés -->
                    <xsl:for-each select="Auteur_production_laas">
                        <xsl:variable name="id_auteur_current" select="@id_auteur"/>

                        <xsl:for-each select="/LAAS/Membres/Membre">
                            <xsl:sort  select="id_membre"/>
                            <xsl:if test="id_membre=$id_auteur_current">
                                <span class="double_indent">
                                    <xsl:value-of select="nom_membre"/>&#160;<xsl:value-of select="prenom_membre"/>&#160;(<em>membre du LAAS</em>)
                                </span>
                                <br/>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:for-each>
                    </p>
                </xsl:for-each>

                <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

                <h2>Articles de conférence : </h2>
                <xsl:for-each select="LAAS/Article_Conference">
                    <xsl:sort select="nom_conf"/>
                    <p>
                        <span class="blue">Titre de l'article : </span>
                        <xsl:value-of select="nom_conf"/>
                        <br/>

                        <span class="blue">Année de publication : </span>
                        <xsl:value-of select="annee_publication"/>
                        <br/>

                        <span class="blue">Nombre de pages : </span>
                        <xsl:value-of select="nombre_pages"/>
                        <br/>

                        <span class="blue">Classe : </span>
                        <xsl:value-of select="classe"/>
                        <br/>

                        <span class="blue">Auteur(s) participant(s) : </span>
                        <br/>

                    <!-- recherche des auteurs externes associés -->
                    <xsl:for-each select="Auteur_production_externe">
                        <xsl:variable name="id_auteur_current" select="@id_auteur"/>

                        <xsl:for-each select="/LAAS/Auteur">
                            <xsl:sort  select="nom"/>
                            <xsl:if test="id_auteur=$id_auteur_current">
                                <span class="double_indent">
                                    <xsl:value-of select="nom"/>
                                </span>
                                <br/>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:for-each>

                    <!-- recherche des auteurs du LAAS associés -->
                    <xsl:for-each select="Auteur_production_laas">
                        <xsl:variable name="id_auteur_current" select="@id_auteur"/>

                        <xsl:for-each select="/LAAS/Membres/Membre">
                            <xsl:sort  select="id_membre"/>
                            <xsl:if test="id_membre=$id_auteur_current">
                                <span class="double_indent">
                                    <xsl:value-of select="nom_membre"/>&#160;<xsl:value-of select="prenom_membre"/>
                                </span>
                                <br/>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:for-each>
                    </p>
                </xsl:for-each>

                <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

                <h2>Partenaires du LAAS : </h2>
                <xsl:for-each select="LAAS/Partenaire">
                    <xsl:sort select="nom"/>
                    <p>
                        <span class="blue">Nom : </span>
                        <xsl:value-of select="nom"/>
                        <br/>

                        <span class="blue">Pays : </span>
                        <xsl:value-of select="pays"/>
                        <br/>
                    </p>
                </xsl:for-each>

                <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

                <h2>Projet de Recherche : </h2>
                <xsl:for-each select="LAAS/Projet_de_Recherche">
                    <xsl:sort select="titre_projet"/>
                    <xsl:variable name="acro_equipe_current" select="acronyme_equipe"/>
                    <xsl:variable name="id_respo" select="id_membre"/>
                    <p>
                        <span class="blue">Titre du projet : </span>
                        <xsl:value-of select="titre_projet"/>
                        <br/>

                        <span class="blue">Acronyme : </span>
                        <xsl:value-of select="acronyme_projet"/>
                        <br/>

                        <span class="blue">Date de début : </span>
                        <xsl:value-of select="date_debut"/>
                        <br/>

                        <span class="blue">Durée : </span>
                        <xsl:value-of select="duree"/>
                        <br/>

                        <span class="blue">Cout : </span>
                        <xsl:value-of select="cout"/>&#160;M€
                        <br/>

                        <span class="blue">Budget : </span>
                        <xsl:value-of select="budget"/>&#160;M€
                        <br/>

                        <span class="blue">Responsable : </span>
                            <xsl:for-each select="/LAAS/Membres/Membre">
                                <xsl:if test="id_membre=$id_respo">
                                    <xsl:value-of select="nom_membre"/>&#160;<xsl:value-of select="prenom_membre"/>
                                    <br/>
                                </xsl:if>
                            </xsl:for-each>

                        <span class="blue">Equipe : </span>
                        <xsl:for-each select="/LAAS/Equipe">
                            <xsl:if test="acronyme_equipe=$acro_equipe_current">
                                <xsl:value-of select="nom_equipe" />
                            </xsl:if>
                        </xsl:for-each>
                        <br/>

                        <span class="blue">Partenaire(s) : </span>
                        <br/>
                        <xsl:for-each select="Partenaire_projet">
                            <span class="simple_indent"><xsl:value-of select="@nom"/></span>
                        <br/>
                        </xsl:for-each>

                        <span class="blue">Rapport(s) associé(s) : </span>
                        <br/>

                        <xsl:for-each select="Rapport_Recherche">
                            <span id="titre_rapport"><xsl:value-of select="nom_rapport_recherche"/></span>
                            <br/>
                            <span class="blue_indent">Année de publication : </span>
                            <xsl:value-of select="annee_publication"/>
                            <br/>

                            <span class="blue_indent">Nombre de pages : </span>
                            <xsl:value-of select="nombre_pages"/>
                            <br/>

                            <span class="blue_indent">Auteur(s) participant(s) : </span>
                            <br/>

                            <!-- recherche des auteurs externes associés -->
                            <xsl:for-each select="Auteur_production_externe">
                                <xsl:variable name="id_auteur_current" select="@id_auteur"/>

                                <xsl:for-each select="/LAAS/Auteur">
                                    <xsl:sort  select="nom"/>
                                    <xsl:if test="id_auteur=$id_auteur_current">
                                        <span class="double_indent">
                                            <xsl:value-of select="nom"/>
                                        </span>
                                        <br/>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:for-each>

                            <!-- recherche des auteurs du LAAS associés -->
                            <xsl:for-each select="Auteur_production_laas">
                                <xsl:variable name="id_auteur_current" select="@id_auteur"/>

                                <xsl:for-each select="/LAAS/Membres/Membre">
                                    <xsl:sort  select="id_membre"/>
                                    <xsl:if test="id_membre=$id_auteur_current">
                                        <span class="double_indent">
                                            <xsl:value-of select="nom_membre"/>&#160;<xsl:value-of select="prenom_membre"/>
                                        </span>
                                        <br/>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:for-each>
                        </xsl:for-each>
                    </p>
                </xsl:for-each>

                <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

                <h2>Thèmes de recherche : </h2>
                <xsl:for-each select="LAAS/Theme">
                    <xsl:sort select="description"/>
                    <xsl:variable name="id_respo" select="id_membre"/>
                    <p>
                        <span class="blue">Theme : </span>
                        <xsl:value-of select="description"/>
                        <br/>

                        <span class="blue">Acronyme : </span>
                        <xsl:value-of select="acronyme_theme"/>
                        <br/>

                        <span class="blue">Responsable : </span>
                        <xsl:for-each select="/LAAS/Membres/Membre">
                            <xsl:if test="id_membre=$id_respo">
                                <xsl:value-of select="nom_membre"/>&#160;<xsl:value-of select="prenom_membre"/>
                                <br/>
                            </xsl:if>
                        </xsl:for-each>
                    </p>
                </xsl:for-each>

                <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

                <h2>Conférences : </h2>
                <xsl:for-each select="LAAS/Conference">
                    <xsl:sort select="nom_evenement"/>
                    <xsl:variable name="acro_equipe_current" select="acronyme_equipe"/>
                    <xsl:variable name="acro_theme_current" select="acronyme_theme"/>

                    <span class="blue">Conférence : </span>
                    <xsl:value-of select="nom_evenement"/>
                    <br/>

                    <span class="blue">Date de début - date de fin : </span>
                    <xsl:value-of select="date_debut"/> - <xsl:value-of select="date_fin"/>
                    <br/>

                    <span class="blue">Equipe organisatrice : </span>
                    <xsl:for-each select="/LAAS/Equipe">
                        <xsl:if test="acronyme_equipe=$acro_equipe_current">
                            <xsl:value-of select="nom_equipe" />
                        </xsl:if>
                    </xsl:for-each>
                    <br/>

                    <span class="blue">Thème associé : </span>
                    <xsl:for-each select="/LAAS/Theme">
                        <xsl:if test="acronyme_theme=$acro_theme_current">
                            <xsl:value-of select="description"/>
                        </xsl:if>
                    </xsl:for-each>
                    <br/>

                    <span class="blue">Classe : </span>
                    <xsl:value-of select="classe"/>
                    <br/>

                </xsl:for-each>

                <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

                <h2>Réunions de groupe : </h2>
                <xsl:for-each select="LAAS/Reunion_groupe">
                    <xsl:sort select="nom_evenement"/>
                    <xsl:variable name="acro_equipe_current" select="acronyme_equipe"/>

                    <span class="blue">Intitulé : </span>
                    <xsl:value-of select="nom_evenement"/>
                    <br/>

                    <span class="blue">Date de début - date de fin : </span>
                    <xsl:value-of select="date_debut"/> - <xsl:value-of select="date_fin"/>
                    <br/>

                    <span class="blue">Equipe concernée : </span>
                    <xsl:for-each select="/LAAS/Equipe">
                        <xsl:if test="acronyme_equipe=$acro_equipe_current">
                            <xsl:value-of select="nom_equipe" />
                        </xsl:if>
                    </xsl:for-each>
                    <br/>
                    <br/>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>