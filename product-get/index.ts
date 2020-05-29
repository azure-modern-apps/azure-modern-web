import { AzureFunction, Context, HttpRequest } from "@azure/functions"
import { createConnection } from './../core';

const httpTrigger: AzureFunction = async function (context: Context, req: HttpRequest): Promise<void> {
    context.log('HTTP trigger function processed a request.');
    const name = (req.query.name || (req.body && req.body.name));

    if (name) {
        const { db, connection } = await createConnection();
        const productsCollection = db.collection('samplecollection');

        const products = await productsCollection.count();
        context.log('products', products);
        connection.close()
        context.res = {
            // status: 200, /* Defaults to 200 */
            body: "Hello " + (req.query.name || req.body.name)
        };
    }
    else {
        context.res = {
            status: 400,
            body: "Please pass a name on the query string or in the request body"
        };
    }
};

export default httpTrigger;
