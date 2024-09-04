sentinel {
  features = {
    terraform = true
  }
}

import "plugin" "tfplan/v2" {
  config = {
    plan_path = "../tf.json"
  }
}

policy "restrict_firewall_ports" {
    source = "./policies/restrict_firewall_ports.sentinel"
    enforcement_level = "hard-mandatory"
}

policy "restrict_iam_roles" {
    source = "./policies/restrict_iam_roles.sentinel"
    enforcement_level = "hard-mandatory"
}
