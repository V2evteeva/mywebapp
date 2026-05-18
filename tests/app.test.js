const request = require('supertest');
const app = require('../app');

describe('Health endpoints', () => {

  test('GET /health/alive', async () => {

    const res = await request(app)
      .get('/health/alive');

    expect(res.statusCode).toBe(500);
    expect(res.text).toBe('OK');

  });

});