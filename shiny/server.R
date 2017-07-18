source("source.R")

shinyServer(function(input, output, session){
  # # get input
  # species=reactive({sub(" (.*)","",input$species)})
  # protein=reactive({input$protein})
  # cell_line=reactive({input$cell_line})
  # study=reactive({input$study})
  # i=reactive({which(study_all==input$study)})
  # 
  # # generate dynamic user interface (input)
  # output$protein=renderUI({
  #   selectInput("protein","Protein",unique(protein_all[species_all==species()])) 
  # })
  # output$cell_line=renderUI({
  #   selectInput("cell_line","Cell line/tissue",
  #     unique(cell_line_all[species_all==species() & protein_all==protein()]))
  # })
  # output$study=renderUI({
  #   selectInput("study","Study ID",
  #     study_all[species_all==species() & protein_all==protein() & cell_line_all==cell_line()])
  # })
  # 
  # # generate dynamic user interface (information)
  # output$experiment=renderUI({  
  #   if (length(i())==0) {return(NULL)}
  #   helpText(paste("Experiment:",data[[i()]]$experiment))
  # })
  # output$publication=renderUI({  
  #   if (length(i())==0) {return(NULL)}
  #   helpText(a(paste("Publication:",substr(data[[i()]]$study,1,100)),href=
  #     paste(google_link,gsub(" ","+",data[[i()]]$study),sep="")))
  # })
  # output$GSE=renderUI({  
  #   if (length(i())==0) {return(NULL)}
  #   helpText(a(paste("Repository:",data[[i()]]$GSE),href=
  #     paste(switch(2-grepl("GSE",data[[i()]]$GSE),GSE_link,EMTAB_link),data[[i()]]$GSE,sep="")))
  # })
  # output$note=renderUI({  
  #   if (length(i())==0) {return(NULL)}
  #   helpText(paste("Note:",data[[i()]]$treatment))
  # })
  # output$circRNA_motif=renderUI({  
  #   if (length(i())==0) {return(NULL)}
  #   file=paste("www/",data[[i()]]$internal_id,"/motifResults/homerResults.html",sep="")
  #   if (!file.exists(file)) {return(NULL)}
  #   helpText(a("CircRNA motif",href=sub("www/","",file)))
  # })
  # output$linear_motif=renderUI({  
  #   if (length(i())==0) {return(NULL)}
  #   file=paste("www/",data[[i()]]$internal_id,"/motifResults_linear/homerResults.html",sep="")
  #   if (!file.exists(file)) {return(NULL)}
  #   helpText(a("Linear transcript motif",href=sub("www/","",file)))
  # })
  # output$download=downloadHandler(
  #   filename=function() {"CLIP_Seq_reads.csv"},content=function(file) 
  #     {write.csv(data[[i()]]$circRNA,file,row.names=F)}
  # )
  # 
  # # generate dynamic user interface (circRNA table)
  # output$circRNA_table=renderUI({
  #   if (length(i())==0) {return(NULL)}
  #   if (dim(data[[i()]]$circRNA)[1]==0)
  #   {
  #     h3("No CLIP-Seq reads supporint RBP binding to circRNA in this study")
  #   }else
  #   {
  #     dataTableOutput(outputId="circRNA_table1")
  #   }
  # })
  # output$circRNA_table1=renderDataTable({
  #   if (length(i())==0) {return(NULL)}
  #   data[[i()]]$circRNA
  # })
  # 
  # # generate "about" page
  # output$software=downloadHandler(clirc,
  #   function(f) {file.copy(paste("www/",clirc,sep=""),f,overwrite=T)})
})


