# Terraform-aws-inbox

Setup of AWS inbox with custom domain

[![Snyk Infrastructure as Code](https://github.com/mikesupertrampster-corp/terraform-aws-inbox/actions/workflows/snyk.yml/badge.svg)](https://github.com/mikesupertrampster-corp/terraform-aws-inbox/actions/workflows/snyk.yml) [![gitleaks](https://github.com/mikesupertrampster-corp/terraform-aws-inbox/actions/workflows/gitleaks.yml/badge.svg)](https://github.com/mikesupertrampster-corp/terraform-aws-inbox/actions/workflows/gitleaks.yml) [![Codacy Badge](https://app.codacy.com/project/badge/Grade/4f9f3ae28ec34a9c8b449e2e1729d34c)](https://www.codacy.com/gh/mikesupertrampster-corp/terraform-aws-inbox/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=mikesupertrampster-corp/terraform-aws-inbox&amp;utm_campaign=Badge_Grade) [![Infracost estimate](https://img.shields.io/badge/Infracost-estimate-5e3f62)](https://dashboard.infracost.io/share/xkgjhqn4rv94366gtt1f9j10ot39g2w8)

## Cost

Estimate cost generated using [Infracost](https://github.com/Infracost/infracost)

```
 Name                                                 Monthly Qty  Unit                        Monthly Cost 
                                                                                                            
 module.identity.aws_route53_record.dkim[0]                                                                 
 ├─ Standard queries (first 1B)               Monthly cost depends on usage: $0.40 per 1M queries           
 ├─ Latency based routing queries (first 1B)  Monthly cost depends on usage: $0.60 per 1M queries           
 └─ Geo DNS queries (first 1B)                Monthly cost depends on usage: $0.70 per 1M queries           
                                                                                                            
 module.identity.aws_route53_record.dkim[1]                                                                 
 ├─ Standard queries (first 1B)               Monthly cost depends on usage: $0.40 per 1M queries           
 ├─ Latency based routing queries (first 1B)  Monthly cost depends on usage: $0.60 per 1M queries           
 └─ Geo DNS queries (first 1B)                Monthly cost depends on usage: $0.70 per 1M queries           
                                                                                                            
 module.identity.aws_route53_record.dkim[2]                                                                 
 ├─ Standard queries (first 1B)               Monthly cost depends on usage: $0.40 per 1M queries           
 ├─ Latency based routing queries (first 1B)  Monthly cost depends on usage: $0.60 per 1M queries           
 └─ Geo DNS queries (first 1B)                Monthly cost depends on usage: $0.70 per 1M queries           
                                                                                                            
 module.identity.aws_route53_record.mx                                                                      
 ├─ Standard queries (first 1B)               Monthly cost depends on usage: $0.40 per 1M queries           
 ├─ Latency based routing queries (first 1B)  Monthly cost depends on usage: $0.60 per 1M queries           
 └─ Geo DNS queries (first 1B)                Monthly cost depends on usage: $0.70 per 1M queries           
                                                                                                            
 module.identity.aws_s3_bucket.inbox                                                                        
 └─ Standard                                                                                                
    ├─ Storage                                Monthly cost depends on usage: $0.023 per GB                  
    ├─ PUT, COPY, POST, LIST requests         Monthly cost depends on usage: $0.005 per 1k requests         
    ├─ GET, SELECT, and all other requests    Monthly cost depends on usage: $0.0004 per 1k requests        
    ├─ Select data scanned                    Monthly cost depends on usage: $0.002 per GB                  
    └─ Select data returned                   Monthly cost depends on usage: $0.0007 per GB                 
                                                                                                            
 module.identity.aws_sns_topic.inbox                                                                        
 ├─ API requests (over 1M)                    Monthly cost depends on usage: $0.50 per 1M requests          
 ├─ HTTP/HTTPS notifications (over 100k)      Monthly cost depends on usage: $0.00 per 100k notifications   
 ├─ Email/Email-JSON notifications (over 1k)  Monthly cost depends on usage: $0.00 per 100k notifications   
 ├─ Kinesis Firehose notifications            Monthly cost depends on usage: $0.00 per 1M notifications     
 ├─ Mobile Push notifications                 Monthly cost depends on usage: $0.00 per 1M notifications     
 ├─ MacOS notifications                       Monthly cost depends on usage: $0.00 per 1M notifications     
 └─ SMS notifications (over 100)              Monthly cost depends on usage: $0.00 per 100 notifications    
                                                                                                            
 OVERALL TOTAL                                                                                        $0.00 
──────────────────────────────────
15 cloud resources were detected:
∙ 6 were estimated, all of which include usage-based costs, see https://infracost.io/usage-file
∙ 7 were free:
  ∙ 1 x aws_s3_bucket_acl
  ∙ 1 x aws_s3_bucket_policy
  ∙ 1 x aws_s3_bucket_public_access_block
  ∙ 1 x aws_ses_domain_dkim
  ∙ 1 x aws_ses_domain_identity
  ∙ 1 x aws_sns_topic_policy
  ∙ 1 x aws_sns_topic_subscription
  ∙ 1 x aws_ses_receipt_rule
  ∙ 1 x aws_ses_receipt_rule_set
```