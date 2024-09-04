policy "restrict_firewall_ports" {
    source = "./restrict_firewall_ports.sentinel"
    enforcement_level = "hard-mandatory"
}

policy "restrict_iam_roles" {
    source = "./restrict_iam_roles.sentinel"
    enforcement_level = "hard-mandatory"
}