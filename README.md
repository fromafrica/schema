# schema
this is the complete collection of sqlite database schemas used in the fromafri.ca system

of course not all data is public, but we want to be transparent about what data we collect and why

## publish to cloudflare
currently the system uses cloudflare to host the sqlite database using their d1 service

publishing it looks like this: `wrangler d1 execute users --file=users.sql`

## migrations
a plan is tackle how to safely push schema changes to production is still a work in progress

## validation
there are several online tools to help validate the schema, including one built into wrangler

it's probably easier just to use an AI tool like ChatGPT to tell you exactly what is wrong, as most sqlite validators will throw obscure errors without specifying the line number or what exactly is wrong