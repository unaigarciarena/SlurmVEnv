good='nodo31 nodo55 nodo49 nodo69 nodo50 nodo53 nodo56 nodo63 nodo42 nodo51 nodo54 nodo72 nodo41 nodo39 nodo57 nodo30 nodo52 nodo45 nodo47 nodo58 nodo71 nodo70 nodo83 nodo40 nodo48 nodo64 nodo62 nodo38 nodo46'

all='nodo29 nodo30 nodo31 nodo32 nodo33 nodo34 nodo35 nodo36 nodo37 nodo38 nodo39 nodo40 nodo41 nodo42 nodo43 nodo45 nodo46 nodo47 nodo48 nodo49 nodo50 nodo51 nodo52 nodo53 nodo54 nodo55 nodo56 nodo57 nodo58 nodo59 nodo60 nodo61 nodo62 nodo63 nodo64 nodo65 nodo66 nodo67 nodo68 nodo69 nodo70 nodo71 nodo72 nodo73 nodo74 nodo75 nodo76 nodo77 nodo78 nodo79 nodo80 nodo81 nodo82 nodo83 nodo84 nodo85 nodo86 nodo87 nodo88'

echo "--exclude "${all[@]} ${good[@]} | tr ' ' '\n' | sort | uniq -u | paste -s -d,
