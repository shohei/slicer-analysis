files = dir()
df <- data.frame(do.call(rbind,fromJSON(readChar(files[1],10e5))))
for (f in files[2:length(files)]){
  df2 <- data.frame(do.call(rbind,fromJSON(readChar(f,10e5))))
  df <- merge(as.data.frame(lapply(df, unlist)),as.data.frame(lapply(df2, unlist)),all=TRUE)  	
}
