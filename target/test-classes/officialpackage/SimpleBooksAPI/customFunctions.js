function generateTLD() {
  const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  let result = '';
  for (let i = 0; i < 63; i++) {
    const randomIndex = Math.floor(Math.random() * characters.length);
    result += characters.charAt(randomIndex);
  }
  return result;
}

function generateRandomClientEmail() {
  const tld = generateTLD().slice(0, Math.floor(Math.random() * 62) + 2);
  const randomString = () => Math.random().toString(36).substring(2);
  const username = randomString().slice(0, Math.floor(Math.random() * 64) + 1);
  const domain = randomString().slice(0, Math.floor(Math.random() * 253) + 2);
  return `${username}@${domain}.${tld}`;
}

generateRandomClientEmail(); // Call the function directly to get a random email
