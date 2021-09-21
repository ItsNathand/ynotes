import 'package:ynotes/core/logic/models_exporter.dart';
import 'package:html/parser.dart' show parse;

class LvsDisciplineConverter {
  static disciplines(d, [periodN = '']) {
    //select period html
    //  print(periodN);
  }

  static List<Grade> grades(gradesData, periodN) {
    List grades = [];
    parse(gradesData).querySelectorAll("tr.odd, tr.even").forEach((period) {
      period
          .querySelector("td.tdReleveRight")!
          .innerHtml
          .split("</span>")
          .forEach((grade) {
        try {
          if (grade != '') {
            if (grade.substring(0, 3) == ' - ') {
              grade = grade.substring(3, grade.length);
            }
            print(grade
                .split(' :')[0]
                .substring(0, grade.split(' :')[0].length - 13));
            print(grade.substring(grade.length - 7, grade.length));
            String value = '';
            String testName = '';
            String periodCode = '';
            String periodName = '';
            String disciplineCode = '';
            String? subdisciplineCode;
            String disciplineName = '';
            bool letters = true;
            String weight = '';
            String scale = '';
            String min = '';
            String max = '';
            String classAverage = '';
            DateTime? date = null;
            bool notSignificant = false;
            String testType = "Interrogation";
            DateTime? entryDate = null;
            bool countAsZero = true;
            grades.add(Grade(
                value: value,
                testName: testName,
                periodCode: periodCode,
                periodName: periodName,
                disciplineCode: disciplineCode,
                subdisciplineCode: subdisciplineCode,
                disciplineName: disciplineName,
                letters: letters,
                weight: weight,
                scale: scale,
                min: min,
                max: max,
                classAverage: classAverage,
                date: date,
                notSignificant: notSignificant,
                testType: testType,
                entryDate: entryDate,
                countAsZero: countAsZero));
          }
        } catch (e) {
          print(e);
        }
      });
    });

    return [];
  }

  static getPeriods(html) {
    List<String?> urls = [];
    html = parse(html);
    html
        .querySelector("ul.periodes")!
        .querySelectorAll('li.periode')
        .forEach((period) {
      var url = period.querySelector('a')!.attributes['href'].toString();
      urls.add(url);
    });
    return urls;
  }

  /*  static getPeriod(html) {
    return content
        .querySelector("ul.periodes")!
        .querySelector(".periode.active")!
        .querySelector('a')!
        .attributes['href']
        .toString();
  } */
}

var content = parse("""
    <!DOCTYPE html><html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr"><head><title>la-vie-scolaire</title><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><link href="/vsn.main/static/css/default/error.css" type="text/css" rel="stylesheet" media="all"><script src="/vsn.main/static/plugins/jquery-1.11.1/js/jquery/jquery-1.11.1.min.js" type="text/javascript"></script><link href="/vsn.main/static/css/jqueryui/themes/smoothness/jquery-ui-1.9.2.custom.min.css" type="text/css" rel="stylesheet" media="screen, projection"><script src="/vsn.main/static/js/jqueryui/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script><link href="/vsn.main/static/bundle-jquery_ui_adapte-5.19.2-1623418640664_head.css" type="text/css" rel="stylesheet" media="screen, projection"><script src="/vsn.main/static/bundle-bundle_chosen_head.js" type="text/javascript"></script><link href="/vsn.main/static/bundle-bundle_chosen_head.css" type="text/css" rel="stylesheet" media="screen, projection"><link href="/vsn.main/static/css/default/styles-1.12.css" type="text/css" rel="stylesheet" media="all"><script src="/vsn.main/static/bundle-core-5.19.2-1623418640664_head.js" type="text/javascript"></script><link href="/vsn.main/static/bundle-core-5.19.2-1623418640664_head.css" type="text/css" rel="stylesheet" media="screen, projection"><link href="/vsn.main/static/css/jprogress/jprogress.ajuste.css" type="text/css" rel="stylesheet" media="screen, projection"><meta name="layout" content="main"></head><body id="top"><script type="text/javascript">var   j=jQuery.noConflict();</script><ul id="skip" class="invisible"><li><a href="#toolbar" accesskey="s">Aller au menu</a></li><li><a href="#content" accesskey="c" title="Aller au contenu">Aller au contenu</a></li></ul><div id="toolbar"><ul id="navmenu-h"><li><a class="arrow">Classe</a><ul><li><a href="/vsn.main/compteRenduCCNote/consulterCompteRenduDuConseil">Compte rendu du conseil de classe</a></li></ul></li><li><a class="arrow">Elève</a><ul><li><a href="/vsn.main/releveNote/releveNotes">Relevé de notes</a></li><li><a href="/vsn.main/bulletinNote/bulletinNotes">Bulletin</a></li><li><a href="/vsn.main/dossierRecapEleve/afficheDossierRecap">Dossier récapitulatif</a></li></ul></li><li class="print_menu"><a target="#" class="print_menu" title="Imprimer"><img class="print_menu" alt="Imprimer" src="/vsn.main/static/images/print.png"></a></li></ul></div><div id="content"><div class="breadcrumbs"><span>Notes > Elève > Relevé de notes</span></div><div class="margeentete"><ul class="periodes"><li class="periode"><a href="/vsn.main/releveNote/changeSynthesePeriode?idSynthesePeriode=44" class="periode">1er Trimestre</a></li><li class="periode"><a href="/vsn.main/releveNote/changeSynthesePeriode?idSynthesePeriode=43" class="periode">2&egrave;me Trimestre</a></li><li class="periode active"><a href="/vsn.main/releveNote/changeSynthesePeriode?idSynthesePeriode=42" class="periode">3&egrave;me Trimestre</a></li></ul><div class="clear"></div></div><table class="tableReleve" summary=""><caption></caption><tr><th class="tdReleveLeft"><strong>Discipline</strong><br>Professeur</th><th class="tdReleveMoy">Moyenne</th><th class="tdReleveRight">Détail des évaluations</th></tr><tr class="odd"><td class="tdReleveLeft"><strong>Fran&ccedil;ais</strong><br>Mme KETTERLIN</td><td class="tdReleveMoy releve-note-moy">16,4</td><td class="tdReleveRight">Notions cours S3 (17/02/2021) : <span class="note">15,8/25</span> - Lecture Andromaque (12/05/2021) : <span class="note">29,0/35</span> - Note incitative lect (28/05/2021) : <span class="note">9,0/10</span> - Notions cours - S4 (28/05/2021) : <span class="note">35,5/42</span> - Participation (02/06/2021) : <span class="note">9,0/10</span></td></tr><tr class="even"><td class="tdReleveLeft"><strong>Math&eacute;matiques</strong><br>M. ADJAHI</td><td class="tdReleveMoy releve-note-moy">16,8</td><td class="tdReleveRight">vecteur (02/06/2021) : <span class="note">15,0/20</span> - proba (02/06/2021) : <span class="note">18,5/20</span></td></tr><tr class="odd"><td class="tdReleveLeft"><strong>Physique-Chimie</strong><br>M. HASSAK</td><td class="tdReleveMoy releve-note-moy">12,3</td><td class="tdReleveRight">Moyennes tp (30/04/2021) : <span class="note">7,0/10</span> - Evaluation (04/06/2021) : <span class="note">11,5/20</span></td></tr><tr class="even"><td class="tdReleveLeft"><strong>Sciences Vie Terre</strong><br>Mme COLLOT</td><td class="tdReleveMoy releve-note-moy">16,0</td><td class="tdReleveRight">Quiziniere (26/03/2021) : <span class="note">abs</span> - QCMs (17/05/2021) : <span class="note">8,0/10</span></td></tr><tr class="odd"><td class="tdReleveLeft"><strong>Histoire-G&eacute;ographie</strong><br>Mme TROUBAT</td><td class="tdReleveMoy releve-note-moy">18,3</td><td class="tdReleveRight">Contr&ocirc;le g&eacute;ographie (01/04/2021) : <span class="note">17,0/20</span> - Evaluation g&eacute;o (18/05/2021) : <span class="note">15,0/15</span> - Evaluation Histoire (18/05/2021) : <span class="note">7,5/10</span> - Expos&eacute; Histoire (01/06/2021) : <span class="note">20,0/20</span></td></tr><tr class="even"><td class="tdReleveLeft"><strong>Anglais LV1</strong><br>Mme GUEGAN</td><td class="tdReleveMoy releve-note-moy">20,0</td><td class="tdReleveRight">EO Article (02/04/2021) : <span class="note">20,0/20</span> - CO (08/04/2021) : <span class="note">10,0/10</span> - CE ou EE (08/04/2021) : <span class="note">10,0/10</span></td></tr><tr class="odd"><td class="tdReleveLeft"><strong>Allemand LV2</strong><br>Mme THIRION</td><td class="tdReleveMoy releve-note-moy">15,3</td><td class="tdReleveRight">EO Wien (02/05/2021) : <span class="note">14,0/20</span> - CE Kunst (16/05/2021) : <span class="note">19,0/20</span> - EE Kunst (29/05/2021) : <span class="note">13,0/20</span></td></tr><tr class="even"><td class="tdReleveLeft"><strong>SC ECO SOC</strong><br>M. DE MAGNIENVILLE</td><td class="tdReleveMoy releve-note-moy">11,7</td><td class="tdReleveRight">DM (02/06/2021) : <span class="note">13,0/20</span> - DST (02/06/2021) : <span class="note">22,0/40</span></td></tr><tr class="odd"><td class="tdReleveLeft"><strong>SNT</strong><br>M. SAID OMAR</td><td class="tdReleveMoy releve-note-moy">20,0</td><td class="tdReleveRight">Photographie (03/06/2021) : <span class="note">20,0/20</span></td></tr><tr class="even"><td class="tdReleveLeft"><strong>E.P.S.</strong><br>Mme EUDE</td><td class="tdReleveMoy releve-note-moy">17,0</td><td class="tdReleveRight">60m (22/03/2021) : <span class="note">17,0/20</span></td></tr><tr class="odd"><td class="tdReleveLeft"><strong>Arts Plastiques</strong><br>Mme MARIE</td><td class="tdReleveMoy releve-note-moy">14,7</td><td class="tdReleveRight">analyse perspective (03/06/2021) : <span class="note">abs</span> - objet design (03/06/2021) : <span class="note">13,5/20</span> - planche design (03/06/2021) : <span class="note">16,0/20</span> - croquis (03/06/2021) : <span class="note">abs</span> - collage (03/06/2021) : <span class="note">14,5/20</span> - NM (03/06/2021) : <span class="note">abs</span></td></tr><tr class="even"><td class="tdReleveLeft"><strong>Latin Option</strong><br>Mme ANDRE</td><td class="tdReleveMoy releve-note-moy">18,4</td><td class="tdReleveRight">Spectre (18/03/2021) : <span class="note">5,0/5</span> - Tableau wiki (30/05/2021) : <span class="note">18,0/20</span></td></tr></table></div><script type="text/javascript">function build_choosen(e){  j(e).length&&(  j(e).is(":hidden")||(  j(e).chosen({placeholder_text_single:"-- choix --",no_results_text:"Aucun résultat",search_contains:!1,enable_split_word_search:!1}),  j(e+"_chosen").css("width",  j(e).outerWidth(!0)+25+"px")))}  j(".choosemenu").removeClass("block"),build_choosen("#idClasse"),build_choosen("#idEleve"),build_choosen("#idTableau"),build_choosen("#idSalle"),build_choosen("#idProf"),build_choosen("#idProfesseur"),build_choosen("#idPalier"),build_choosen("#idCompetence"),build_choosen("#idDomaineItem"),build_choosen("#idTypeDevoir"),build_choosen("#codeStructure");</script><a href="#top" id="totop" title="Retour en haut de la page">Haut de page</a><script src="/vsn.main/static/bundle-utils-5.19.2-1623418640664_defer.js" type="text/javascript"></script><script src="/vsn.main/static/bundle-jquery_ui_adapte-5.19.2-1623418640664_defer.js" type="text/javascript"></script><script type="text/javascript">if(/iP(ad|od|hone)/i.test(window.navigator.userAgent)){var   j=jQuery.noConflict();  j("#submenu").on("touchstart",function(e){var o=  j(this),s=  j(this).parent().find("ul");e.preventDefault(),e.stopPropagation(),o.hasClass("ui-state-focus")?(o.removeClass("ui-state-focus"),s.attr("aria-hidden","true"),s.attr("aria-expanded","false"),s.css("display","none")):(o.addClass("ui-state-focus"),s.removeAttr("aria-hidden"),s.attr("aria-expanded","true"),s.css("display","block"),s.css("position","absolute"),s.css("left","100%"),s.css("right","auto"),s.css("top","85%"),  j(this).parent().find("a").attr("pointer-events","none"),  j(this).parent().find("a").attr("cursor","not-allowed"))})}</script><script type="text/javascript">var   j=jQuery.noConflict();hidePrint(),  j(function(){  j.datepicker.setDefaults(  j.datepicker.regional.fr),  j.datepicker.setDefaults({firstDay:1}),initMenu()}),  j("#contentAccueil").length>0&&hideTotop();</script><script type="text/javascript">  j(document).ajaxError(function(e,t,o,s){  j("#content").html(t.responseText)});</script></body></html>""");
