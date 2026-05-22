<?php

namespace jeu\carte;

use conf\ConnecteurDAO as ConnecteurDAO;

class SVG
{
    public static function rectangle($x, $y, $hauteur, $largeur, $param = null)
    {
        $arg = '';
        if (isset($param)) {
            foreach ($param as $nom => $valeur) {
                $arg .= $nom . '="' . $valeur . '" ';
            }
        }
        return '<rect x="' . $x . '" y="' . $y . '" width="' . $largeur . '" height="' . $hauteur . '" ' . $arg . '/>' . PHP_EOL;
    }

    public static function carre($x, $y, $taille, $param)
    {
        return SVG::rectangle($x, $y, $taille, $taille, $param);
    }

    public static function ellipse($x, $y, $hauteur, $largeur, $param = null)
    {
        $rx = $largeur / 2;
        $ry = $hauteur / 2;
        $arg = '';

        if (isset($param)) {
            foreach ($param as $nom => $valeur) {
                $arg .= $nom . '="' . $valeur . '" ';
            }
        }
        return '<ellipse cx="' . $x . '" cy="' . $y . '" rx="' . $rx . '" ry="' . $ry . '" ' . $arg . '/>' . PHP_EOL;
    }

    public static function cercle($x, $y, $rayon, $param = null)
    {
        $r = $rayon / 2;
        $arg = '';

        if (isset($param)) {
            foreach ($param as $nom => $valeur) {
                $arg .= $nom . '="' . $valeur . '" ';
            }
        }
        return '<circle cx="' . $x . '" cy="' . $y . '" r="' . $r . '" ' . $arg . '/>' . PHP_EOL;
    }

    public static function ligne($x_depart, $y_depart, $x_arrive, $y_arrive, $classe = null)
    {
        return '<line class="' . $classe . '" x1="' . $x_depart . '" y1="' . $y_depart . '" x2="' . $x_arrive . '" y2="' . $y_arrive . '" />' . PHP_EOL;
    }

    public static function polygoneOuvert($tableau, $classe = null)
    {
        $points = implode(",", $tableau);
        return '<polyline class="' . $classe . '" points="' . $points . '" />' . PHP_EOL;
    }

    public static function polygone($tableau, $classe = null)
    {
        $points = implode(",", $tableau);
        return '<polygon class="' . $classe . '" points="' . $points . '" />' . PHP_EOL;
    }

    public static function texte($x, $y, $texte)
    {
        return '<text x="' . $x . '" y="' . $y . '">' . $texte . '</text>' . PHP_EOL;
    }

    public static function popup($x, $y, $parent, $texte)
    {

        /*$largeur = strlen($texte) * 20;
        $hauteur = 20;

        $rect = SVG::rectangle($x, $y, $hauteur, $largeur, array('class' => 'blanc'));*/

        return '<text id="' . $parent . '_popup" x="' . $x . '" y="' . $y . '" font-size="20" fill="black" visibility="hidden">' . $texte . '
			<set attributeName="visibility" from="hidden" to="visible" begin="' . $parent . '.mouseover" end="' . $parent . '.mouseout"/>
		</text>';
    }

    public static function tableauJavascript($tableau)
    {
        return '';
    }

    public static function image($y, $x, $y_max, $x_max, $data)
    {
        return '<image x="' . $x . '" y="' . $y . '" width="' . $x_max . '" height="' . $y_max . '" preserveAspectRatio="none" xlink:href="data:image/png;base64,' . $data . '" />';
    }

    public static function header($titre, $largeur, $hauteur, $date, $css = null)
    {

        $retour = '<?xml version="1.0" standalone="no"?>
		<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" 
		"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
		<svg width="' . $largeur . '" height="' . $hauteur . '" version="1.1"
		xmlns="http://www.w3.org/2000/svg"
		xmlns:xlink="http://www.w3.org/1999/xlink">
		<title>' . $titre . '</title>
		<script type="text/ecmascript"> 
		<![CDATA[
		
			top.getAllBouclier = getAllBouclier;
			top.getElem = getElem;
			top.getSvg = getSvg;		
		
			var Date = ' . $date . ';
			var TableBouclier = new Array();
			TableBouclier["bouclier_4"] = "Bouclier Humain : Terra";
			TableBouclier["bouclier_7"] = "Aero";
			TableBouclier["bouclier_9"] = "Ultima";
			TableBouclier["bouclier_11"] = "Bouclier T2";
			
			function getElem(methode){
				return eval(methode);
			}
			
			
			function getSvg(){
				return document;
			}
			
			function getAllBouclier(){
				return TableBouclier;
			}

		]]></script>
		';

        if (!isset($css)) {
            $retour .= '<style type="text/css" >
			  <![CDATA[

				.fond_terre {
				   fill:   rgb(170, 221, 170);
				}
				
				.fond_ciferis {
				   fill:   rgb(223, 170, 170);
				}		

				.fond_celestia {
				   fill:   rgb(170, 170, 221);
				}
				
				.humain {
				   fill:   rgb(0,200,0);
				}		
				
				.roi {
				   fill:   rgb(0,200,0);
				}	

				.paria {
				   fill:   rgb(200,0,200);
				}
				
				.aa {
				   fill:   rgb(0,0,200);
				}

				.ange {
				   fill:   rgb(0,0,200);
				}

				.sd {
				   fill:   rgb(200,0,0);
				}

				.demon {
				   fill:   rgb(200,0,0);
				}

				.noir {
				   fill:   rgb(0,0,0);
				}
				
				.axe {
				   fill:   rgb(0,0,0);
				}		

				.bouclier {
				   fill:   rgb(0,100,100);
				}	

				.viseurs {
					stroke: rgb(200,0,0);
					fill-opacity: 0.05;
				}
				
				.blanc {
					fill:	rgb(255,255,255);
				}

			  ]]>
			</style>';
        }

        return $retour;
    }

    public static function footer()
    {
        echo '</svg>';
    }

    public static function javascript()
    {
        return '
		<text id="thingyouhoverover" x="50" y="35" font-size="14">Mouse over me!</text>
		
		<text id="thepopup" x="250" y="100" font-size="30" fill="black" visibility="hidden">Change me
			<set attributeName="visibility" from="hidden" to="visible" begin="thingyouhoverover.mouseover" end="thingyouhoverover.mouseout"/>
		</text>';
    }
}
