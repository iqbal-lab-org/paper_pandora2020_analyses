#=====================
# setup
#=====================
library(assertr)
library(ggplot2)
library(data.table)
library(ggthemr)
library(tidyverse)
library(ggnewscale)
library(gridExtra)

#=====================
# Read in data
#=====================


df_illumina <- read.csv("df_illumina.R_data.csv", header=TRUE)
df_illumina$NUMBER_OF_SAMPLES <- as.factor(df_illumina$NUMBER_OF_SAMPLES)
df_nanopore <- read.csv("df_nanopore.R_data.csv", header=TRUE)
df_nanopore$NUMBER_OF_SAMPLES <- as.factor(df_nanopore$NUMBER_OF_SAMPLES)

tool_palette <-fread("tool_palette.csv",header=TRUE, sep=",")
unique(df_illumina$tool) %in% tool_palette$tool 


illumina_colour_palette = tool_palette %>% 
  filter(tool %in% unique(df_illumina$tool)) %>% 
  pull(palette)



ggthemr('fresh')


#=====================================
# Illumina: amount of variants found
#=====================================

custom_label= expression(paste("pandora ", italic("de novo")))


illumina_variants = ggplot(df_illumina, aes(x=NUMBER_OF_SAMPLES, y=nb_of_found_PanVar, fill=tool)) +
  geom_boxplot(data = df_illumina[df_illumina$tool != "pandora with denovo", ],
               aes(group=interaction(NUMBER_OF_SAMPLES, tool)),
               outlier.colour="black", outlier.shape=8, 
               outlier.size = 0.5, position=position_dodge(1)) +
  geom_line(data = df_illumina[df_illumina$tool == "pandora with denovo", ],
            aes(x=NUMBER_OF_SAMPLES, y=nb_of_found_PanVar,  linetype = "dashed"),
            inherit.aes = FALSE, size=0.5, group = 1) +
  scale_fill_manual(values=c(illumina_colour_palette[2:3]), name="", labels = c("samtools","snippy")) +
  scale_linetype_manual(name="", labels=c(custom_label), values=c("dashed" = "dashed"))+
  ylim(0, 80000) +
  ylab("Number of pan-variants found") +
  xlab("Number of samples") +
  theme(legend.position = "None") + 
  labs(tag="a") +
  theme(axis.text.x = element_text(angle = 45, hjust =1)) 


#=====================================
# Illumina: recall
#=====================================
illumina_recall = ggplot(df_illumina, aes(x=NUMBER_OF_SAMPLES, y=recall_PVR, fill=tool)) +
  geom_boxplot(data = df_illumina[df_illumina$tool != "pandora with denovo", ],
               aes(group=interaction(NUMBER_OF_SAMPLES, tool)),
               outlier.colour="black", outlier.shape=8, 
               outlier.size = 0.5, position=position_dodge(1)) +
  geom_line(data = df_illumina[df_illumina$tool == "pandora with denovo", ],
            aes(x=NUMBER_OF_SAMPLES, y=recall_PVR,  linetype = "dashed"),
            inherit.aes = FALSE, size=0.5, group = 1) +
  scale_fill_manual(values=c(illumina_colour_palette[2:3]), name="", labels = c("samtools","snippy")) +
  scale_linetype_manual(name="", labels=c(custom_label), values=c("dashed" = "dashed"))+
  ylim(0, 1) +
  ylab("Pan-variants recall") +
  xlab("Number of samples") +
  theme(legend.position = "None") + 
  labs(tag="c") +
  theme(axis.text.x = element_text(angle = 45, hjust =1)) 



#=====================================
# Illumina: average allelic recall
#=====================================
illumina_avg_allelic_recall = ggplot(df_illumina, aes(x=NUMBER_OF_SAMPLES, y=recall_AvgAR, fill=tool)) +
  geom_boxplot(data = df_illumina[df_illumina$tool != "pandora with denovo", ],
               aes(group=interaction(NUMBER_OF_SAMPLES, tool)),
               outlier.colour="black", outlier.shape=8, 
               outlier.size = 0.5, position=position_dodge(1)) +
  geom_line(data = df_illumina[df_illumina$tool == "pandora with denovo", ],
            aes(x=NUMBER_OF_SAMPLES, y=recall_AvgAR,  linetype = "dashed"),
            inherit.aes = FALSE, size=0.5, group = 1) +
  scale_fill_manual(values=c(illumina_colour_palette[2:3]), name="", labels = c("samtools","snippy")) +
  scale_linetype_manual(name="", labels=c(custom_label), values=c("dashed" = "dashed"))+
  ylim(0, 1) +
  ylab("Average allelic recall") +
  xlab("Number of samples") +
  theme(legend.position = "None") + 
  labs(tag="a")+
  theme(axis.text.x = element_text(angle = 45, hjust =1)) 





#=====================================
# Nanopore:amount of variants found
#=====================================
unique(df_nanopore$tool) %in% tool_palette$tool 


nanopore_colour_palette = tool_palette %>% 
  filter(tool %in% unique(df_nanopore$tool)) %>% 
  pull(palette)


nanopore_variants = ggplot(df_nanopore, aes(x=NUMBER_OF_SAMPLES, y=nb_of_found_PanVar, fill=tool)) +
  geom_boxplot(data = df_nanopore[df_nanopore$tool != "pandora with denovo", ],
               aes(group=interaction(NUMBER_OF_SAMPLES, tool)),
               outlier.colour="black", outlier.shape=8, 
               outlier.size = 0.5, position=position_dodge(1)) +
  geom_line(data = df_nanopore[df_nanopore$tool == "pandora with denovo", ],
            aes(x=NUMBER_OF_SAMPLES, y=nb_of_found_PanVar,  linetype = "dashed"),
            inherit.aes = FALSE, size=0.5, group = 1) +
  scale_fill_manual(values=c(nanopore_colour_palette[1:2]), name="", labels = c("medaka","nanopolish")) +
  scale_linetype_manual(name="", labels=c(custom_label), values=c("dashed" = "dashed"))+
  ylim(0, 80000) +
  ylab("Number of pan-variants found") +
  xlab("Number of samples") +
  theme(legend.position = "None") + 
  labs(tag="b") +
  theme(axis.text.x = element_text(angle = 45, hjust =1)) 
  
  
  

#=====================================
# Nanopore: recall
#=====================================
nanopore_recall = ggplot(df_nanopore, aes(x=NUMBER_OF_SAMPLES, y=recall_PVR, fill=tool)) +
  geom_boxplot(data = df_nanopore[df_nanopore$tool != "pandora with denovo", ],
               aes(group=interaction(NUMBER_OF_SAMPLES, tool)),
               outlier.colour="black", outlier.shape=8, 
               outlier.size = 0.5, position=position_dodge(1)) +
  geom_line(data = df_nanopore[df_nanopore$tool == "pandora with denovo", ],
            aes(x=NUMBER_OF_SAMPLES, y=recall_PVR,  linetype = "dashed"),
            inherit.aes = FALSE, size=0.5, group = 1) +
  scale_fill_manual(values=c(nanopore_colour_palette[1:2]), name="", labels = c("medaka","nanopolish")) +
  scale_linetype_manual(name="", labels=c(custom_label), values=c("dashed" = "dashed"))+
  ylim(0, 1) +
  ylab("Pan-variants recall") +
  xlab("Number of samples") +
  theme(legend.position = "None") + 
  labs(tag="d") +
  theme(axis.text.x = element_text(angle = 45, hjust =1)) 



#=====================================
# Nanopore: average allelic recall
#=====================================
nanopore_avg_allelic_recall = ggplot(df_nanopore, aes(x=NUMBER_OF_SAMPLES, y=recall_AvgAR, fill=tool)) +
  geom_boxplot(data = df_nanopore[df_nanopore$tool != "pandora with denovo", ],
               aes(group=interaction(NUMBER_OF_SAMPLES, tool)),
               outlier.colour="black", outlier.shape=8, 
               outlier.size = 0.5, position=position_dodge(1)) +
  geom_line(data = df_nanopore[df_nanopore$tool == "pandora with denovo", ],
            aes(x=NUMBER_OF_SAMPLES, y=recall_AvgAR,  linetype = "dashed"),
            inherit.aes = FALSE, size=0.5, group = 1) +
  scale_fill_manual(values=c(nanopore_colour_palette[1:2]), name="", labels = c("medaka","nanopolish")) +
  scale_linetype_manual(name="", labels=c(custom_label), values=c("dashed" = "dashed"))+
  ylim(0, 1) +
  ylab("Average allelic recall") +
  xlab("Number of samples") +
  theme(legend.position = "None") + 
  labs(tag="b") +
  theme(axis.text.x = element_text(angle = 45, hjust =1)) 





#=====================================
# Make custom legend
#=====================================
df_legend = rbind(df_illumina, df_nanopore)


custom_legend_plot = ggplot(df_legend, aes(x=NUMBER_OF_SAMPLES, y=recall_AvgAR, fill=tool)) +
  geom_boxplot(data = df_legend[df_legend$tool != "pandora with denovo", ],
               aes(group=interaction(NUMBER_OF_SAMPLES, tool)),
               outlier.colour="black", outlier.shape=8, 
               outlier.size = 0.5, position=position_dodge(1)) +
  geom_line(data = df_legend[df_legend$tool == "pandora with denovo", ],
            aes(x=NUMBER_OF_SAMPLES, y=recall_AvgAR,  linetype = "dashed"),
            inherit.aes = FALSE, size=0.5, group = 1) +
  scale_fill_manual(values=c(illumina_colour_palette[3:2],nanopore_colour_palette[2:1]), 
                    name="", labels = c( "snippy","samtools","nanopolish","medaka")) +
  scale_linetype_manual(name="", labels=c(custom_label), values=c("dashed" = "dashed"))+
  ylim(0, 1) +
  ylab("Average allelic recall") +
  xlab("Number of samples") +
  theme(legend.position = "bottom", legend.title = element_blank()) 



g_legend<-function(a.gplot){
  tmp <- ggplot_gtable(ggplot_build(a.gplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)}

custom_legend<-g_legend(custom_legend_plot)


#=====================================
# Nanopore only legend
#=====================================
df_legend = rbind(df_nanopore)

custom_legend_nanopore_only_plot = ggplot(df_legend, aes(x=NUMBER_OF_SAMPLES, y=recall_AvgAR, fill=tool)) +
  geom_boxplot(data = df_legend[df_legend$tool != "pandora with denovo", ],
               aes(group=interaction(NUMBER_OF_SAMPLES, tool)),
               outlier.colour="black", outlier.shape=8,
               outlier.size = 0.5, position=position_dodge(1)) +
  geom_line(data = df_legend[df_legend$tool == "pandora with denovo", ],
            aes(x=NUMBER_OF_SAMPLES, y=recall_AvgAR,  linetype = "dashed"),
            inherit.aes = FALSE, size=0.5, group = 1) +
  scale_fill_manual(values=c(nanopore_colour_palette[2:1]),
                    name="", labels = c("nanopolish","medaka")) +
  scale_linetype_manual(name="", labels=c(custom_label), values=c("dashed" = "dashed"))+
  ylim(0, 1) +
  ylab("Average allelic recall") +
  xlab("Number of samples") +
  theme(legend.position = "bottom", legend.title = element_blank())

g_legend<-function(a.gplot){
  tmp <- ggplot_gtable(ggplot_build(a.gplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)}

custom_legend_nanopore_only<-g_legend(custom_legend_nanopore_only_plot)

# #=====================================
# # Make multi-panel fig and write out
# #=====================================
nanopore_only_fig = grid.arrange(arrangeGrob(nanopore_variants+labs(tag="a"), nanopore_recall+labs(tag="b"), nrow=1),
                            custom_legend_nanopore_only, nrow=2, heights=c(5,1))
ggsave(nanopore_only_fig, file="recall_per_number_of_samples_nanopore.png", width=15, height=5, dpi=300)



top_half_fig = grid.arrange(arrangeGrob(illumina_variants, 
                                        nanopore_variants,
                                        nrow=1),
                            custom_legend, nrow=2, heights=c(10,1))
bottom_half_fig = grid.arrange(arrangeGrob(illumina_recall, 
                                           nanopore_recall,
                                           nrow=1))
final_plot = grid.arrange(top_half_fig, bottom_half_fig)

ggsave(final_plot, file="recall_per_number_of_samples_all.png", width=15, height=10, dpi=300)




supp_fig = grid.arrange(arrangeGrob(illumina_avg_allelic_recall, 
                                    nanopore_avg_allelic_recall,
                                    nrow=1),
                        custom_legend, nrow=2, heights=c(10,1))

ggsave(supp_fig, file="recall_per_number_of_samples_all_avgar.png", width=15, height=5, dpi=300)





