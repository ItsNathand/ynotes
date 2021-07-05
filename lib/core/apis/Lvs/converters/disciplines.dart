//https://institutsaintpierresaintpaul28.la-vie-scolaire.fr/vsn.main/releveNote/changeSynthesePeriode?idSynthesePeriode=42
//periods 1: 44 2:43 3:42
//https://institutsaintpierresaintpaul28.la-vie-scolaire.fr/vsn.main/dossierRecapEleve/afficheDetailNotes
//ex for prev:
/*<h2></h2>
<table id="tableNotes" class="tablesorter">
    <thead>
        <tr>
            
                <th class="recapTabHead">Période</th>
            
                <th class="recapTabHead"><p>2020</p><p>2nde2</p></th>
            
                <th class="recapTabHead">Moy. classe</th>
            
        </tr>
    </thead>
    <tbody>
        
    <tr class="">
        
            
                <td  class=""><a href="javascript:void(0)" id="44" class="toggleDetailPeriode">1er Trimestre</a></td>
            
        
            
                <td  class=""><span class="strong">17,6</span></td>
            
        
            
                <td  class="">14,5</td>
            
        
    </tr>

    <tr class="">
        
            
                <td  class=""><a href="javascript:void(0)" id="43" class="toggleDetailPeriode">2ème Trimestre</a></td>
            
        
            
                <td  class=""><span class="strong">16,5</span></td>
            
        
            
                <td  class="">14,4</td>
            
        
    </tr>

    <tr class="">
        
            
                <td  class=""><a href="javascript:void(0)" id="42" class="toggleDetailPeriode">3ème Trimestre</a></td>
            
        
            
                <td  class=""><span class="strong">17,7</span></td>
            
        
            
                <td  class="">15,3</td>
            
        
    </tr>

    <tr class="">
        
            
                <td  class=""><a href="javascript:void(0)" id="41" class="toggleDetailPeriode">Année</a></td>
            
        
            
                <td  class=""><span class="strong">17,3</span></td>
            
        
            
                <td  class="">14,8</td>
            
        
    </tr>

    </tbody>
</table>
<script type="application/javascript" >
    jQuery(document).ready(function($)
        {
            $.tablesorter.addParser({
                id: 'dateAHeure',
                is: function(s) {
                    return s.match(/^(\d{2})\/(\d{2})\/(\d{4}) à (\d{2})h(\d{2})$/);
                },
                format: function(s) {
                    var valeurRetour = '0';
                    var digitpattern = /\d+/g;
                    var matches = s.match(digitpattern);
                    if(matches != null) {
                        var year = matches[2];
                        var month = matches[1];
                        var day = matches[0];
                        var hour = matches[3];
                        var minute = matches[4];
                        var second = 0;
                        var millisecond = 0;
                        valeurRetour = new Date(year, month, day, hour, minute, second, millisecond).getTime();
                    }
                    return $.tablesorter.formatFloat(valeurRetour);
                },
                type: "numeric"
            });

            $.tablesorter.addParser({
                id: 'jourMoisAnnee',
                is: function(s) {
                    return s.match(/^(\d{2})\/(\d{2})\/(\d{4})$/);
                },
                format: function(s) {
                    var valeurRetour = '0';
                    var digitpattern = /\d+/g;
                    var matches = s.match(digitpattern);
                    if(matches != null) {
                        var year = matches[2];
                        var month = matches[1];
                        var day = matches[0];
                        var hour = matches[0];
                        var minute = matches[0];
                        var second = 0;
                        var millisecond = 0;
                        valeurRetour = new Date(year, month, day, hour, minute, second, millisecond).getTime();
                    }
                    return $.tablesorter.formatFloat(valeurRetour);
                },
                type: "numeric"
            });

            $("#tablePunitions, #tableSanctions").tablesorter({
                headers:{
                    0:{sorter:'dateAHeure'},
                    1:{sorter:'dateAHeure'},
                    5:{sorter:'jourMoisAnnee'}
                }
            });

            $("#tableIncidents").tablesorter({
                headers:{
                    0:{sorter:'jourMoisAnnee'}
                }
            });
        }
    );
</script>
<div id="toto"></div>

<script type="text/javascript">
    initDetailNote();
</script>*/
