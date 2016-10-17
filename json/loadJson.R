files <- dir()
for (f in files){
 jsons<-append(jsons,fromJSON(readChar(f, 1e5)))
}
df<-do.call(rbind,jsons)
df <- data.frame(df)


ggplot(df,aes(x=as.numeric(df$support_material_interface_spacing)))+geom_histogram()
ggplot(df,aes(x=as.numeric(df$support_material_interface_spacing)))+geom_density()

