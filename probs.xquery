<html>
    <head>
        <title>XML Classwork</title>
    </head>
    <body>
    <table>
    <tr>
        <th><b>Target</b></th>
        <th><b>Successor</b></th>
        <th><b>Probability</b></th>
    </tr>
    {
        return   
            for $w in $s/w
            return
                if(lower-case(normalize-space($w/text())) eq 'has') 
                    then
                        let $succ := (data($s/w[.>> $w][1]))
                        return
                             (:use ',' as separator of 'has'-succ tuple:)
                             <tuple> {lower-case(normalize-space($w/text()))} {','}{lower-case(normalize-space($succ))}</tuple>
                    else  ()
    let $all_words := for $s in collection('resources?select=*.xml')//s
        return 
            for $w in $s/w
            return <word>{lower-case(normalize-space($w/text()))}</word>   
    for $distinct in distinct-values($has_succ_tuple/text())
        let $d := (($has_succ_tuple[text() = $distinct])[1])
        let $arr := tokenize($d, ',')
        let $count := count($has_succ_tuple[text() = $distinct])
        let $total_count := count($all_words[text()=$arr[2]])
        let $probability := round-half-to-even($count div $total_count, 2)
        order by $probability descending, $arr[2] ascending
        return
            <tr>
                <td>{$arr[1]}</td>
                <td>{$arr[2]}</td>
                <td>{$probability}</td>
            </tr>
    }
    </table>
    </body>
</html>