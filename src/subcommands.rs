use clap::{Parser, Subcommand};

mod build_config;
mod run;

use crate::subcommands::build_config::BuildConfigSubcommand;
use crate::subcommands::run::RunSubcommand;

/// Enhance your game's lore
#[derive(Parser, Debug)]
#[command(version, about, long_about = None)]
pub struct Args {
    #[clap(subcommand)]
    pub command: Subcommands,
}

#[derive(Debug, Subcommand)]
pub enum Subcommands {
    Run(RunSubcommand),
    Build(BuildConfigSubcommand),
}
