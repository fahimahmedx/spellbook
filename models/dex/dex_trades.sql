{{ config(
        alias ='trades',
        post_hook='{{ expose_spells(\'["ethereum", "bnb", "avalanche_c", "gnosis", "optimism", "arbitrum", "fantom", "polygon"]\',
                                "sector",
                                "dex",
                                \'["jeff-dude", "hosuke", "0xRob", "pandajackson42", "Henrystats", "scoffie", "zhongyiio", "justabi", "umer_h_adil", "mtitus6", "dbustos20", "tian7", "bh2smith"]\') }}'
        )
}}


{% set dex_trade_models = [
 ref('uniswap_trades')
,ref('sushiswap_trades')
,ref('kyberswap_trades')
,ref('fraxswap_trades')
,ref('curvefi_trades')
,ref('airswap_ethereum_trades')
,ref('clipper_trades')
,ref('shibaswap_ethereum_trades')
,ref('swapr_ethereum_trades')
,ref('defiswap_ethereum_trades')
,ref('dfx_ethereum_trades')
,ref('pancakeswap_trades')
,ref('dodo_trades')
,ref('velodrome_optimism_trades')
,ref('woofi_trades')
,ref('bancor_ethereum_trades')
,ref('platypus_finance_avalanche_c_trades')
,ref('trader_joe_trades')
,ref('hashflow_trades')
,ref('mstable_ethereum_trades')
,ref('mdex_bnb_trades')
,ref('zigzag_trades')
,ref('nomiswap_bnb_trades')
,ref('gmx_trades')
,ref('biswap_bnb_trades')
,ref('wombat_bnb_trades')
,ref('iziswap_bnb_trades')
,ref('babyswap_bnb_trades')
,ref('apeswap_trades')
,ref('ellipsis_finance_trades')
,ref('spartacus_exchange_fantom_trades')
,ref('spookyswap_fantom_trades')
,ref('beethoven_x_trades')
,ref('rubicon_trades')
,ref('synthetix_spot_trades')
,ref('zipswap_trades')
,ref('equalizer_exchange_fantom_trades')
,ref('wigoswap_fantom_trades')
,ref('arbswap_trades')
,ref('balancer_trades')
,ref('spiritswap_fantom_trades')
,ref('quickswap_trades')
,ref('maverick_trades')
] %}


SELECT *
FROM (
    {% for dex_model in dex_trade_models %}
    SELECT
        blockchain,
        project,
        version,
        block_date,
        block_time,
        token_bought_symbol,
        token_sold_symbol,
        token_pair,
        token_bought_amount,
        token_sold_amount,
        token_bought_amount_raw,
        token_sold_amount_raw,
        amount_usd,
        token_bought_address,
        token_sold_address,
        taker,
        maker,
        project_contract_address,
        tx_hash,
        tx_from,
        tx_to,
        trace_address,
        evt_index
    FROM {{ dex_model }}
    {% if not loop.last %}
    UNION ALL
    {% endif %}
    {% endfor %}
)
