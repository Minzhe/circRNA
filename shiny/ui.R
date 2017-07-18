library(shiny)
load("circRNA_all.RData")
species_all <- unique(sapply(data, function(x) x$species))
proteins_all <- sort(unique(sapply(data, function(x) x$protein)))
cell_line_all <- unique(sapply(data, function(x) x$cell_line))
study_all <- unique(sapply(data, function(x) x$internal_id))

shinyUI(
    navbarPage("RBP-circRNA interaction database",
        tabPanel("View interactions",
            sidebarPanel(
                selectInput(inputId = "species", label = "Species", choices = species_all),
                selectInput(inputId = "protein", label = "Protein", choices = proteins_all),
                selectInput(inputId = "cell_line", label = "Cell line/tissue", choices = cell_line_all),
                selectInput(inputId = "study", label = "Study ID", choices = study_all)
            )
        )
    )
)