terraform {
  backend "s3" {
    bucket = "darrensimio-ops"
    key    = "terraform/state/kb-darrensim-io.tfstate"
    region = "us-east-1"
  }
}