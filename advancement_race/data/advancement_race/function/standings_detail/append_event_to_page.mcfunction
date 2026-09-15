$data modify storage advancement_race:runtime standings_detail.pages[-1].raw.extra append value {text:"\n\n#$(sequence) ",color:"#666666",bold:false}
$data modify storage advancement_race:runtime standings_detail.pages[-1].raw.extra append value {translate:"$(title_translate)",color:"#2B2B2B",bold:false}
$data modify storage advancement_race:runtime standings_detail.pages[-1].raw.extra append value {text:"\nAdvancement Place: $(place)  +$(points) Points",color:"#8A6500",bold:false}
