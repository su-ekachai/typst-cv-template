#import "../templates/lib.typ": *

#let profile = toml("../data/profile.toml")
#let cl = toml("../data/cover_letter.toml")

// Build the author dict, including optional contact fields only when non-empty
// (prevents stray "|" separators in the contact line).
#let author = (
  firstname: profile.firstname,
  lastname: profile.lastname,
  positions: profile.positions,
)
#for key in ("email", "phone", "github", "linkedin", "homepage", "address") {
  if profile.at(key, default: "") != "" {
    author.insert(key, profile.at(key))
  }
}

#show: coverletter.with(
  author: author,
  signature: if cl.letter.at("use-signature", default: false) {
    image("../assets/images/signature.png", width: 150pt)
  },
  language: "en",
  show-footer: false,
  show-address-icon: false,
  paper-size: "us-letter",
)

#hiring-entity-info(
  entity-info: (
    target: cl.company.target,
    name: cl.company.name,
    street-address: cl.company.street-address,
    city: cl.company.city,
  ),
)

#letter-heading(
  job-position: cl.letter.job-position,
  addressee: cl.letter.addressee,
)

#for paragraph in cl.letter.paragraphs {
  coverletter-content[#paragraph]
}
