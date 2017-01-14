#!/usr/bin/RScript

empty_plot <- ggplot() + geom_density(alpha=0.2) +
              labs(title="Hill-Equation Dose-Response Model", x="RESPONSE", y="DENSITY") + 
              theme(plot.title=element_text(size=rel(2)),
                    axis.text=element_text(size=rel(1.5)),
                    axis.title=element_text(size=rel(1.5)),
                    legend.position="top", legend.text=element_text(size=rel(2)),
                    legend.title=element_text(size=rel(2))) +
              guides(fill=guide_legend(title="DOSE:"))
