`makecommunitydataset` <-
    function(x, row, column, value, factor="", level="", drop=F)
{
    x[, row] <- as.factor(x[, row])
    x[, column] <- as.factor(x[, column])
    if(factor != "") {
        subs <- x[, factor]==level
        for (q in 1:length(subs)) {
            if(is.na(subs[q])) {subs[q]<-F}
        }
        x <- x[subs, , drop=F]        
    }
    x[, row] <- x[, row][drop=drop]
    x[, column] <- x[, column][drop=T]
    result <- table(x[, row], x[, column])
    rows <- rownames(result)
    r <- length(rows)
    cols <- colnames(result)
    c <- length(cols)
    result2 <- array(dim=c(r, c))
    for (i in 1:r){
        sub1 <- x[,row]==rows[i]
        subset <- x[sub1, ]
        for (j in 1:c) {
            sub2 <- subset[, column]==cols[j]
            subset2 <- subset[sub2, ]
            result2[i,j] <- sum(subset2[, value])
        }
    }
    rownames(result2) <- make.names(rownames(result), unique=T)
    colnames(result2) <- make.names(colnames(result), unique=T)
    result2 <- as.data.frame(result2)
    return(result2)
}

