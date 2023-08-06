# App 𝙒𝙃𝘼𝙏 𝙄𝙎 𝙏𝙃𝙀 𝙉𝙀𝙒𝙎 📰
<img src="https://github.com/GregDeveaux/GregDeveaux/blob/main/documents/WhatIsTheNews-2.png" width="230" height="480" align="right">

➜ 𝙒𝙃𝘼𝙏 𝙄𝙎 𝙏𝙃𝙀 𝙉𝙀𝙒𝙎 est une application "en français 🇫🇷" sur l’actualité récente, <br/>
elle permet de récupérer l'ensemble des articles, selon un thème précis ou <br/>
une recherche par mot clé, de lire l'article sur le site du créateur de ce contenu<br/> 
tout en restant dans l'application elle-même.
<br/>
<br/>

## Fonctionnement 
À l'ouverture de 𝙒𝙃𝘼𝙏 𝙄𝙎 𝙏𝙃𝙀 𝙉𝙀𝙒𝙎, l'application affiche 2 types d'actualités différentes :
<br /> 
- une première dans la partie logo qui est un <b>carousselle présentant 3 news</b> d'un thème</br>
- déjà défini qui est la musique 🎸 (non modifiable pour l'instant)
- une seconde présentant les news dans une <b>liste déroulante</b> qui a pour thème Apple</br>
- à l'ouverture, mais qui pourra modifiée ultérieurement.
<br/>
<br/>
L'application offre la possibilité de choisir son thème d'actualités favori, pour cela il suffit de cliquer </br>
sur le <b>bouton vert loupe 🔍</b> qui se trouve en bas à droite pour modifier le contenu des actualités. <br/>
<br/>
Celui-ci actionne une nouvelle vue de page avec l'option de recherche, pour indiquer un mot clé</br>
pour une recherche d'actus spécifiques ou choisir un thème parmi les 9 proposés comme </br>on peut le voir ci-dessous.
<br/>
<br/>
Dans la partie avec mot clé, le champs ne pourra valider une nouvelle recherche que si celui  </br>
n'est pas vide, le bouton rechercher du keyboard ne sera pas actif.
<br/>
<br/>
<p>
<img src="https://github.com/GregDeveaux/GregDeveaux/blob/main/documents/WhatIsTheNews-11.png" width="300" height="665">
<img src="https://upload.wikimedia.org/wikipedia/commons/c/ca/1x1.png" width="30">
<img src="https://github.com/GregDeveaux/GregDeveaux/blob/main/documents/WhatIsTheNews-12.png" width="300" height="665">
</p>
<br/>
Ensuite après avoir effectué la recherche (ici Apple), une liste s'affiche avec le nouveau thème choisi. </br>
<br/>
Après avoir trouvé l'article voulu pendant le scrolling de la liste, une simple pression permet d'afficher une nouvelle vue contenant<br/> 
plus d'information sur la news comme une description, l'auteur, la source et un bouton contenant le lien pour accéder à la page web</br> 
de l'article qui s'affiche directement dans l'application.<br/>
<br/>

<p>
<img src="https://github.com/GregDeveaux/GregDeveaux/blob/main/documents/WhatIsTheNews-4.png" width="260" height="550">
<img src="https://upload.wikimedia.org/wikipedia/commons/c/ca/1x1.png" width="30">
<img src="https://github.com/GregDeveaux/GregDeveaux/blob/main/documents/WhatIsTheNews-5.png" width="260" height="550">
<img src="https://upload.wikimedia.org/wikipedia/commons/c/ca/1x1.png" width="30">
<img src="https://github.com/GregDeveaux/GregDeveaux/blob/main/documents/WhatIsTheNews-7.png" width="260" height="550">

</p>
<br/>

## Design
Le design rappele les journaux d'antant grâce à l'utilisation d'une couleur de fond semblable au papier journal, de la typographie serif<br/> 
pour les titre dans un bleu profond et aux photos en noir et blanc avec la trame visible (sur la version light mode).<br/>
le tout est agrémenté d'un logo et d'une couleur vive qui rajeunissent l'ensemble et le rend plus contemporain.
<br/>
Pour le dark mode, les couleurs sont inversées, le bleu profond est repris pour le background et les fonts deviennent blanches<br/> 
papier journal, comme on peut le voir ci-dessous.
<br/>
<p>
  <img src="https://github.com/GregDeveaux/GregDeveaux/blob/main/documents/WhatIsTheNews-3.png" width="260" height="550">
  <img src="https://upload.wikimedia.org/wikipedia/commons/c/ca/1x1.png" width="30">
  <img src="https://github.com/GregDeveaux/GregDeveaux/blob/main/documents/WhatIsTheNews-4.png" width="260" height="550">
  <img src="https://upload.wikimedia.org/wikipedia/commons/c/ca/1x1.png" width="30">
  <img src="https://github.com/GregDeveaux/GregDeveaux/blob/main/documents/WhatIsTheNews-5.png" width="260" height="550">
</p>

<p>
<img src="https://github.com/GregDeveaux/GregDeveaux/blob/main/documents/WhatIsTheNews-9.png" width="260" height="550">
<img src="https://upload.wikimedia.org/wikipedia/commons/c/ca/1x1.png" width="30">
<img src="https://github.com/GregDeveaux/GregDeveaux/blob/main/documents/WhatIsTheNews-8.png" width="260" height="550">
<img src="https://upload.wikimedia.org/wikipedia/commons/c/ca/1x1.png" width="30">
<img src="https://github.com/GregDeveaux/GregDeveaux/blob/main/documents/WhatIsTheNews-6.png" width="260" height="550">
</p>

## Bug et Axe d'amélioration
- BUG: Le carousselle devait fonctionner seul et afficher une nouvelle page toute les 5 secondes mais provoque un crash.
- BUG: Les images se réactualisent toutes (caroussel et liste) lors du changement de page du caroussel.
- UPDATE: Pouvoir changer les différents thèmes pour en faire des raccourcis personnalisables.
- UPDATE: Pour le carouselle, permettre repérer les thèmes favoris de l'utilisateur et faire un random des actus
- UPDATE: Ajouter de l'animation sur certains éléments
