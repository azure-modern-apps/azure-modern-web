import { AzureFunction, Context, HttpRequest } from "@azure/functions"
import { createConnection, Product } from './../core';
const { ObjectID } = require('mongodb')

const httpTrigger: AzureFunction = async function (context: Context, req: HttpRequest): Promise<void> {
    const { db, connection } = await createConnection();
    const productsCollection = db.collection<Product>('samplecollection');
    const product:Product = {id:req.body.id, name: req.body.name, price: req.body.price};

    try {
        const result = await productsCollection.findOneAndUpdate(
            { _id: ObjectID(product.id) },
            { $set: product }
          )        
        connection.close();
        context.res = {
            body: result
        };
    } catch (error) {
        connection.close();
        context.res = {
            status: 400,
            body: 'error' + error
        };
    };

};

export default httpTrigger;
