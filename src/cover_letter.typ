#import "../templates/lib.typ": *

#let profile = toml("../data/profile.toml")
#let cl = toml("../data/cover_letter.toml")

#show: coverletter.with(
  author: (
    firstname: profile.firstname,
    lastname: profile.lastname,
    email: profile.email,
    phone: profile.phone,
    github: profile.github,
    linkedin: profile.linkedin,
    homepage: profile.homepage,
    positions: profile.positions,
  ),
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
