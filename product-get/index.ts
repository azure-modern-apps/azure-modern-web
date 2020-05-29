import { AzureFunction, Context, HttpRequest } from "@azure/functions"
import { createConnection, Product } from './../core';

const httpTrigger: AzureFunction = async function (context: Context, req: HttpRequest): Promise<void> {
    const { db, connection } = await createConnection();
    const productsCollection = db.collection<Product>('samplecollection');

    try {
        const products = await productsCollection.find({}).limit(20).toArray();
        connection.close();
        context.res = {
            body: products
        };
    } catch (error) {
        context.res = {
            status: 400,
            body: 'error' + error
        };
    };

};

export default httpTrigger;
