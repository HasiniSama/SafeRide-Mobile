import swaggerJsdoc from "swagger-jsdoc";

const options = {
    definition: {
        openapi: '3.0.0',
        servers: [
            {
                url: "http://localhost:8000"
            },
        ],
        info: {
            title: 'Safe Ride Mobile',
            version: '1.0.0',
        },
    },
    apis: ['./routes/*.js'],
};

export const swaggerSpec = swaggerJsdoc(options);
