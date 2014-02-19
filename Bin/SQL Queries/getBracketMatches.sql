SELECT        awayBout.boutID, awayBout.evta_fname AS a_fname, awayBout.evta_lname AS a_lname, awayBout.evta_grade AS a_grade, awayBout.btr_winner AS a_winner, 
                         awayBout.btr_winType AS a_winType, awayBout.Total AS a_total, homeBouts.evta_fname AS h_fname, homeBouts.evta_lname AS h_lname, 
                         homeBouts.evta_grade AS h_grade, homeBouts.btr_winner AS h_winner, homeBouts.btr_winType AS h_winType, homeBouts.Total AS h_total, 
                         brackets.bracketID AS bracketID
FROM            bouts INNER JOIN
                         brackets ON bouts.bracketID = brackets.bracketID INNER JOIN
                         awayBout INNER JOIN
                         homeBouts ON awayBout.boutID = homeBouts.boutID ON bouts.boutID = awayBout.boutID AND bouts.boutID = homeBouts.boutID
WHERE        (brackets.eventID = 1025) AND (brackets.bracketID = 2)