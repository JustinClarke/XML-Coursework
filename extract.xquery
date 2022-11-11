<html>
    <head>
        <title>XML Classwork</title>
    </head>
    <body>
    <table>
    <tr>
        <th><b>Target</b></th>
        <th><b>Successor</b></th>
    </tr>
    {
    for $s in collection('resources?select=*.xml')//s
        return   
            for $w in $s/w
            return
                    then
                        let $succ := (data($s/w[.>> $w][1]))
                        return
                        <tr>
                            <td> {data($w)}</td>
                            <td>{$succ}</td>
                        </tr>
                    else  ()
    }
    </table>
    </body>
</html>
