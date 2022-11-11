<html>
    <head>
        <title>XML Classwork</title>
    </head>
    <body>
    <table>
    <tr>
        <th><b>Target</b></th>
        <th><b>Successor</b></th>
        <th><b>Frequency</b></th>
    </tr>
    {
        let $has_succ_tuple := for $s in collection('resources?select=*.xml')//s
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
    for $distinct in distinct-values($has_succ_tuple/text())
        let $count := count($has_succ_tuple[text() = $distinct])
        let $d := (($has_succ_tuple[text() = $distinct])[1])
        let $arr := tokenize($d, ',')
        order by $count descending
        return
            <tr>
                <td>{$arr[1]}</td>
                <td>{$arr[2]}</td>
                <td>{$count}</td>
            </tr>
    }
    </table>
    </body>
</html>
