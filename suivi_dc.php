<!DOCTYPE html>
<html>
	<head>
		<title>Suivi DC</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="content-type" content="application/xhtml+xml; charset=UTF-8">
		<meta http-equiv="content-style-type" content="text/css">
        <link href="suivi_dc.css" rel="stylesheet" type="text/css">
	</head>
	<body>
		<!-- Parcours par pages -->

		<h1>RECHERCHE D'UN DECES</h1>
		<form action="suivi_dc.php" method="get">
			<input type="text" name="mot">
			<input type="submit" value="?">
		</form>
		<?php
			if(isset($_GET['mot']))
				{
				// Affichage du résultat			
				echo '<table border="1">';
				echo '<tr>';
					echo '<th>Nom</th>';
					echo '<th>Prénom</th>';
					echo '<th>Pays</th>';
				echo '</tr>';
				// connexion
				$conn = pg_connect('host=127.0.0.1 dbname=dc user=dc_admin password=admin');
				// Valeur à modifier
				$cherche = strtoupper($_GET['mot']);
				if(!isset($_GET['of']))
					{
					$string_req = "select count(*) from dc join pays on pays.id_pays = dc.id_pays where dc.nom like '%".$cherche."%'";
					$req = pg_query($string_req);
					$taille = pg_fetch_row($req)[0];
					$off=0;
					}
				else 
					{
					$off = $_GET['of'];
					$taille = $_GET['taille']; 
					}
				$string_req = "select dc.nom, prenom, pays.nom as pays  from dc join pays on pays.id_pays = dc.id_pays where dc.nom like '%".$cherche."%' order by dc.nom, prenom";
				$string_req .= ' offset '.$off.' limit 20'; 
				$req = pg_query($string_req);
				$tab = pg_fetch_assoc($req);
				while($tab) 
					{
					echo '<tr>';
						echo '<td>'.$tab['nom'].'</td>';
						echo '<td>'.$tab['prenom'].'</td>';
						echo '<td>'.$tab['pays'].'</td>';
					echo '</tr>';
					$tab = pg_fetch_assoc($req);
					}
				pg_close($conn);
				echo "</table>\n";
				$off_avant = $off+20;
				$off_avant = $off_avant>=$taille?((int)($taille/20))*20:$off_avant;
				$off_arriere = $off-20;
				$off_arriere = $off_arriere<0?0:$off_arriere;
				$string_arriere = 'suivi_dc.php?mot='.$cherche.'&of='.$off_arriere.'&taille='.$taille;
				$string_avant = 'suivi_dc.php?mot='.$cherche.'&of='.$off_avant.'&taille='.$taille;
				echo '<a href="'.$string_arriere.'">←</a>';
				// affichage des pages
				for($i=0; $i<=$taille; $i=$i+20)
					{
					$string_page = 'suivi_dc.php?mot='.$cherche.'&of='.$i.'&taille='.$taille;
					echo '<a href="'.$string_page.'"> '.(int)($i/20).' </a>';
					}
				echo '<a href ="'.$string_avant.'">→</a>';
				}
		?>
	</body>
</html>
			