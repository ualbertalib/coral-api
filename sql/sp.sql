DELIMITER //

CREATE PROCEDURE `q_lic` (IN docid INT)
BEGIN
    select * from Document, Expression where Document.documentID = Expression.documentID and  Document.documentID = docid;

END //
